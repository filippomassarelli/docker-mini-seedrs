module Api
    module V1
        class InvestmentsController < ApplicationController

            # Here we need to definie the a the controller actions for each route
             
            def create
     
                investment = Investment.new(investment_params)

                # binding.irb

                if investment.currency != 'GBP'

                    render json: {status: 'ERROR 406', message:'Invalid investment: currency must be GBP', data:investment.currency}, status: :not_acceptable 
                
                elsif Campaign.ids.exclude? investment.campaign_id

                    render json: {status: 'ERROR 404', message:'Invalid investment: campaign id not found', data:investment.campaign_id}, status: :not_found 

                elsif (investment.investment_amount % Campaign.find(id=investment.campaign_id).investment_multiple).round(2) != 0
                    
                    render json: {status: 'ERROR 403', message:"Invalid investment: investment amount is not a multiple of #{Campaign.find(id=investment.campaign_id).investment_multiple}", data:investment.investment_amount}, status: :forbidden 

                elsif !(Campaign.find(id=investment.campaign_id).open)
                    
                    render json: {status: 'ERROR 406', message:"Invalid investment: Sorry, this campaign is no longer open for investment", data:Campaign.find(id=investment.campaign_id).open}, status: :not_acceptable 

                elsif investment.save

                    render json: {status: 'SUCCESS 201', message:"Valid investment: Thank you for supporting the wonderful!", data:investment}, status: :created

                else
                    render json: {status: 'ERROR 422', data: investment.errors}, status: :unprocessable_entity
                end   
            end


            private

            # DOING SOMETHING WRONG WITH MY A BSTRACTIONS

            # def find_multiple
            #     Campaign.find(id=investment.campaign_id).investment_multiple
            # end

            def investment_params
                params.require(:investment).permit(
                        :campaign_id,
                        :user_name, 
                        :investment_amount, 
                        :currency
                    )
            end

        end
    end
end