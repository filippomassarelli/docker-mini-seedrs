require 'rails_helper'

describe 'Investments API', type: :request do

    describe 'POST /investments' do

        let!(:campaign) { Campaign.create({
            name: Faker::Company.name,
            image: Faker::Company.logo,
            percentage_raised: Faker::Number.between(from: 20, to: 200),
            target_amount: Faker::Number.decimal(l_digits: 6, r_digits: 2),
            sector: Faker::Company.industry,
            country: Faker::Address.country,
            investment_multiple: Faker::Number.decimal(l_digits: 1, r_digits: 2),
            currency: 'GBP',
            open: true
        })}    

        it 'creates a new investment with a good request' do

            post '/api/v1/investments', params: {
                investment: {
                    campaign_id: "#{campaign.id}",
                    user_name: "Filippo",
                    investment_amount: campaign.investment_multiple,
                    currency: 'GBP'
                }
            }
            expect(response).to have_http_status(:created)
        end

        it 'invalidates the investment if the currency is wrong' do

            post '/api/v1/investments', params: {
                investment: {
                    campaign_id: "#{campaign.id}",
                    user_name: "Filippo",
                    investment_amount: campaign.investment_multiple,
                    currency: 'XRP'
                }
            }
            expect(response).to have_http_status(:not_acceptable)
        end

        it 'invalidates the investment if the campaign id is not found' do

            post '/api/v1/investments', params: {
                investment: {
                    campaign_id: 0,
                    user_name: "Filippo",
                    investment_amount: campaign.investment_multiple,
                    currency: 'GBP'
                }
            }
            expect(response).to have_http_status(:not_found)
        end

        it 'invalidates the investment if it does not respect the investment multiple of the campaign' do

            post '/api/v1/investments', params: {
                investment: {
                    campaign_id: "#{campaign.id}",
                    user_name: "Filippo",
                    investment_amount: 0.3,
                    currency: 'GBP'
                }
            }
            expect(response).to have_http_status(:forbidden)
        end

    end

    describe 'POST /investments' do

        let!(:campaign) { Campaign.create({
            name: Faker::Company.name,
            image: Faker::Company.logo,
            percentage_raised: Faker::Number.between(from: 20, to: 200),
            target_amount: Faker::Number.decimal(l_digits: 6, r_digits: 2),
            sector: Faker::Company.industry,
            country: Faker::Address.country,
            investment_multiple: Faker::Number.decimal(l_digits: 1, r_digits: 2),
            currency: 'GBP',
            open: false
        })}   

        it 'invalidates the investment if the campaign is closed' do

            post '/api/v1/investments', params: {
                investment: {
                    campaign_id: "#{campaign.id}",
                    user_name: "Filippo",
                    investment_amount: campaign.investment_multiple,
                    currency: 'GBP'
                }
            }
            expect(response).to have_http_status(:not_acceptable)
        end
    end
end