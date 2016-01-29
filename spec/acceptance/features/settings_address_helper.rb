def test_address_form(address_type)
  address_name = "#{address_type.gsub('_', ' ').capitalize}"
  address_id = "##{address_type}"
    scenario "User registers #{address_name}" do
      within(address_id) do
        fill_in 'First name',     with: @customer.firstname
        fill_in 'Last name',      with: @customer.lastname
        fill_in 'Street address', with: @address.address
        fill_in 'City',           with: @address.city
        fill_in 'Country',        with: @address.country
        fill_in 'Zip',            with: @address.zipcode
        fill_in 'Phone',          with: @address.phone
        click_button 'Save'
      end

      expect(find('.alert-success').text).to eq "#{address_name} has been created"
      within(address_id) do
        expect(find_field('First name').value).to     eq @customer.firstname
        expect(find_field('Last name').value).to      eq @customer.lastname
        expect(find_field('Street address').value).to eq @address.address
        expect(find_field('City').value).to           eq @address.city
        expect(find_field('Country').value).to        eq @address.country
        expect(find_field('Zip').value).to            eq @address.zipcode.to_s
        expect(find_field('Phone').value).to          eq @address.phone
      end
    end

    scenario "User tries to register #{address_name} with all fields are empty" do
      within(address_id) do
        click_button 'Save'
      end
      expect(find('.alert-danger').text).to match 'Address'
      expect(find('.alert-danger').text).to match 'Zipcode'
      expect(find('.alert-danger').text).to match 'City'
      expect(find('.alert-danger').text).to match 'Country'
      expect(find('.alert-danger').text).to match 'Phone'
    end

    scenario "User tries to register #{address_name} with one empty required field" do
      within(address_id) do
        fill_in 'First name',     with: @customer.firstname
        fill_in 'Last name',      with: @customer.lastname
        fill_in 'Street address', with: @address.address
        fill_in 'City',           with: @address.city
        fill_in 'Country',        with: @address.country
        fill_in 'Zip',            with: @address.zipcode

        click_button 'Save'
      end

      expect(find('.alert-danger').text).to match 'Phone'
      within(address_id) do
        expect(find_field('First name').value).to     eq @customer.firstname
        expect(find_field('Last name').value).to      eq @customer.lastname
        expect(find_field('Street address').value).to eq @address.address
        expect(find_field('City').value).to           eq @address.city
        expect(find_field('Country').value).to        eq @address.country
        expect(find_field('Zip').value).to            eq @address.zipcode.to_s
        expect(find_field('Phone').value).to          eq ''
      end
    end
end