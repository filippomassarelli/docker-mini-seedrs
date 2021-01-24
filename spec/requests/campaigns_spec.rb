require 'rails_helper'

describe 'Campaigns API', type: :request do

    describe 'GET /campaigns' do

        # Before this test create dummy data in test database (test database is different than development database)
        before do
            2.times do
                Campaign.create({
                    name: Faker::Company.name,
                    image: Faker::Company.logo,
                    percentage_raised: Faker::Number.between(from: 20, to: 200),
                    target_amount: Faker::Number.decimal(l_digits: 6, r_digits: 2),
                    sector: Faker::Company.industry,
                    country: Faker::Address.country,
                    investment_multiple: Faker::Number.decimal(l_digits: 1, r_digits: 2),
                    currency: 'GBP',
                    open: Faker::Boolean.boolean(true_ratio: 0.75)
                })
            end
        end

        it 'returns all campaigns' do

            get '/api/v1/campaigns'

            expect(response).to have_http_status(:success)
            expect(JSON.parse(response.body).size).to eq(2)
        end
    end
    

    describe 'GET /campaign' do

        # Before this test also create dummy data 
        # let allows you to define variables outside the it block, thus making the actual test implementation small (easier to read)
        # bang (!) ensures that when the test first starts there is one campaign in the database

        let!(:campaign) { Campaign.create({
            name: Faker::Company.name,
            image: Faker::Company.logo,
            percentage_raised: Faker::Number.between(from: 20, to: 200),
            target_amount: Faker::Number.decimal(l_digits: 6, r_digits: 2),
            sector: Faker::Company.industry,
            country: Faker::Address.country,
            investment_multiple: Faker::Number.decimal(l_digits: 1, r_digits: 2),
            currency: 'GBP',
            open: Faker::Boolean.boolean(true_ratio: 0.75)
        })}    
    
        it 'returns one campaign of given id' do
            get "/api/v1/campaigns/#{campaign.id}"
            expect(response).to have_http_status(:success)
        end
    end
end