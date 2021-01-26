module Api
    module V1
        class CampaignsController < ApplicationController

            def index
                if params[:target_above]
                    campaigns = Campaign.where("target_amount > ?", params[:target_above])

                elsif params[:target_below]
                    campaigns = Campaign.where("target_amount < ?", params[:target_below])

                elsif params[:sector]
                    campaigns = Campaign.where(sector: params[:sector])

                else
                    campaigns = Campaign.all
                end

                render json: CampaignsRepresenter.new(campaigns).as_json
            end

            def show
                campaign = Campaign.find(params[:id])
                render json: CampaignRepresenter.new(campaign).as_json            
            end

            def open
                campaigns = Campaign.open
                render json: CampaignsRepresenter.new(campaigns).as_json
            end

            def target_desc
                campaigns = Campaign.target_desc
                render json: CampaignsRepresenter.new(campaigns).as_json
            end

            def target_asc
                campaigns = Campaign.target_asc
                render json: CampaignsRepresenter.new(campaigns).as_json
            end

            def open_and_target_desc
                campaigns = Campaign.open_and_target_desc
                render json: CampaignsRepresenter.new(campaigns).as_json
            end

            def open_and_target_asc
                campaigns = Campaign.open_and_target_asc
                render json: CampaignsRepresenter.new(campaigns).as_json
            end

        end
    end
end