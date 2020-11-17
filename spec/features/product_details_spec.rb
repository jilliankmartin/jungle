require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do
  
    # SETUP
    before :each do
      @category = Category.create! name: 'Apparel'
  
      
      @category.products.create!(
          id: 12,
          name:  "spinny hat",
          description: Faker::Hipster.paragraph(4),
          image: open_asset('apparel1.jpg'),
          quantity: 10,
          price: 64.99
        )
      
    end

    scenario "They can navigate from home page to the product page" do
      visit '/'
      find_link("spinny hat").click
      visit '/products/12'
      save_screenshot
      expect(page).to have_content 'spinny hat'
      expect(page).to have_selector('h1', text: 'Apparel » spinny hat')
    end

end

# visit root_path
# visit '/'
# find_button("Add").click
# find_link("My Cart (1)").click
# expect(page).to have_selector('h1', text: 'My Cart')
# expect(page).to have_content 'Product Name'