class CampaignRepresenter

    def initialize(campaign)
        @campaign = campaign
    end

    def as_json
            {
                id: campaign.id,
                name: campaign.name,
                image: campaign.image,
                percentage_raised: (campaign.percentage_raised + ( ( Investment.where(:campaign_id => campaign.id).map { |record| record[:investment_amount] }.sum ) * 100 / campaign.target_amount)).round(2),
                investment_count: 1 + Investment.where(:campaign_id => campaign.id).count,
                target_amount: campaign.target_amount,
                sector: campaign.sector,
                country: campaign.country,                
                investment_multiple: campaign.investment_multiple,
                is_open: campaign.open
            }
    end

    private

    attr_reader :campaign

end