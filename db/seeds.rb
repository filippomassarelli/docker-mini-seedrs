sectors = ['Advertising & Marketing', 'Automotive & Transport', 'Clothing & Accessories', 'Content & Information', 'Data & Analytics', 'Energy', 'Entertainment', 'Fintech', 'Food & Beverage', 'Games', 'Healthcare', 'Home & Personal', 'Programming & Security', 'Property', 'Recruitment & Procurement', 'SaaS/PaaS', 'Travel, Leisure & Sport']

50.times do 
    Campaign.create({
        name: Faker::Company.name,
        image: Faker::Company.logo,
        percentage_raised: Faker::Number.between(from: 20, to: 150),
        target_amount: Faker::Number.between(from: 80000, to: 1600000),
        # sector: Faker::Company.industry,
        sector: sectors.sample,
        country: Faker::Address.country,
        investment_multiple: Faker::Number.decimal(l_digits: 1, r_digits: 2),
        currency: 'GBP',
        open: Faker::Boolean.boolean(true_ratio: 0.75)
    })
end
