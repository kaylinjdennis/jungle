require 'rails_helper'

RSpec.feature "Visitor can navigate to product page", type: :feature, js: true do
  # SETUP
	before :each do
		@category = Category.create! name: 'Apparel'
		10.times do |n|
			@category.products.create!(
				name: Faker::Hipster.sentence(3),
				description: Faker::Hipster.paragraph(4),
				image: open_asset('apparel1.jpg'),
				quantity: 10,
				price: 64.99
			)
		end
	end

  scenario "They see product-specific page" do
    # ACT
		visit root_path

		# click_on 'Details'
		first('article.product').click_on 'Details'

		puts page.html
		# DEBUG / VERIFY
		expect(page).to have_content 'Quantity'
		# save_screenshot
  end
end
