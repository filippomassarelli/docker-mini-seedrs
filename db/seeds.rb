50.times do 
    Campaign.create({
        name: Faker::Company.name,
        image: Faker::Company.logo,
        percentage_raised: Faker::Number.between(from: 20, to: 150),
        target_amount: Faker::Number.between(from: 80000, to: 1600000),
        sector: Faker::Company.industry,
        country: Faker::Address.country,
        investment_multiple: Faker::Number.decimal(l_digits: 1, r_digits: 2),
        currency: 'GBP',
        open: Faker::Boolean.boolean(true_ratio: 0.75)
    })
end
