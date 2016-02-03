require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  before(:each) do
    @user = create(:user, customer: create(:customer))
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in @user
  end

  describe 'GET #new' do
    let(:book) { build_stubbed(:book) }

    context "when User doesn't have Customer profile" do
      before(:each) do
        @user.update_attribute(:customer, nil)
      end

      it "redirects to Settings page" do
          get(:new, book_id: book.id)
          expect(response).to redirect_to(edit_user_customer_path(@user))
      end
    end

    it "receives 'find' with 'book_id' argument" do
      expect(Book).to receive(:find).with(book.id.to_s)
      get(:new, book_id: book.id)
    end

    it "assigns @book with found object" do
      allow(Book).to receive(:find).and_return(book)
      get(:new, book_id: book.id)
      expect(assigns(:book)).to eq book
    end

    it "assigns @review with 'Review.new'" do
      review = build(:review)
      allow(Book).to receive(:find)
      allow(Review).to receive(:new).and_return(review)
      get(:new, book_id: book.id)
      expect(assigns(:review)).to eq review
    end
  end

  describe 'POST #create' do
    let(:book) { build_stubbed(:book) }
    let(:review_params) { attributes_for(:review).stringify_keys }

    before(:each) do
      @reviews = double('Books reviews', '<<': true)
      allow(Book).to receive(:find).and_return(book)
      allow(book).to receive(:save).and_return(true)
      allow(book).to receive(:reviews).and_return(@reviews)
      @review = build(:review)
      allow(Review).to receive(:new).and_return(@review)
    end

    it { should permit(:title, :text, :value).
          for(:create, params: { book_id: book.id, review: review_params }).
          on(:review) }

    it "receives 'find' with 'book_id' argument" do
      expect(Book).to receive(:find).with(book.id.to_s).and_return(book)
      patch(:create, book_id: book.id, review: review_params)
    end

    it "assigns @book with found object" do
      patch(:create, book_id: book.id, review: review_params)
      expect(assigns(:book)).to eq book
    end

    it "calls 'Review.new' with 'review_params'" do
      expect(Review).to receive(:new).with(review_params).and_return(@review)
      patch(:create, book_id: book.id, review: review_params)
    end

    it "assigns review customer with current user" do
      patch(:create, book_id: book.id, review: review_params)
      expect(@review.customer).to eq @user.customer
    end

    it "adds new review to books reviews" do
      expect(@reviews).to receive(:<<).with(@review)
      patch(:create, book_id: book.id, review: review_params)
    end

    context "when review was saved successfully" do
      it "redirects to book page" do
        patch(:create, book_id: book.id, review: review_params)
        expect(response).to redirect_to book
      end
    end

    context "when review was not saved" do
      before(:each) do
        allow(@reviews).to receive(:<<).and_return(false)
      end

      it "flashes notice according to review save status" do
        expect(controller).to receive(:display_flash).with(@review, any_args)
        patch(:create, book_id: book.id, review: review_params)
      end

      it "renders :new template" do
        patch(:create, book_id: book.id, review: review_params)
        expect(response).to render_template(:new)
      end

      it "assigns @review" do
        patch(:create, book_id: book.id, review: review_params)
        expect(assigns(:review)).to eq @review
      end
    end
  end
end
