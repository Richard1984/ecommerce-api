require 'rails_helper'

RSpec.describe "Products", type: :request do
  describe "GET /index" do

    setup do
      @keyboards = ["Keyboard RGB", "Cheap keyboard", "MechanicalKeyboard"]
      @non_keyboards = ["Cabbage"]

      @keyboards.each do |name|
        Product.create!(name: name, availability: 10, price: "1.48", description: "Description", category_id: nil, available: true)
      end

      @non_keyboards.each do |name|
        Product.create!(name: name, availability: 10, price: "1.48", description: "Description", category_id: nil, available: true)
      end
    end

    context  "given no search term or sorting criteria" do
      it "returns all products" do
        get "/products"
        
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        
        response_json = JSON.parse(response.body)
        expect(response_json["data"].length).to eq(@keyboards.length + @non_keyboards.length)
      end
    end

    context  "given search term keyboard" do
      it "returns all keyboard products" do
        get "/products?search_name=keyboard"
        
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        
        response_json = JSON.parse(response.body)
        expect(response_json["data"].length).to eq(@keyboards.length)

        response_json["data"].each do |product|
          expect(product["name"].downcase).to include("keyboard")
        end
      end
    end

    context  "given sorting criteria 'name' and sorting order 'desc'" do
      it "returns all products sorted by name in descending order" do
        get "/products?sort_criteria=name&sort_order=desc"
        
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        
        response_json = JSON.parse(response.body)
        expect(response_json["data"].length).to eq(@keyboards.length + @non_keyboards.length)

        previous_name = response_json["data"][0]["name"].downcase
        response_json["data"].each do |product|
          puts "#{previous_name} > #{product["name"].downcase}"
          expect(product["name"].downcase).to be <= previous_name

          previous_name = product["name"].downcase
        end
      end
    end
  end
end
