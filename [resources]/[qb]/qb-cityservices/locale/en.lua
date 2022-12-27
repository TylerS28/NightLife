local Translations = {
    target = {
        job = 'Employment Opportunities',
        counter = 'Pickup Counter',
        registered_company = 'Registered Company',
        owned_companies = 'Player Owned Businesses',
    },
    menu = {
        currency = '$%{amount}',
        apply = 'Apply',
        close = 'Close',
        back = 'Back',
        confirm = 'Confirm',
        confirm_and_invest = 'Confirm Investment',
        invest_now = 'Invest Now',
        register = 'Register',
        purchase = 'Purchase',
        sell = 'Sell',
        edit = 'Edit',
        change = 'Change',
        company_type = 'Type:',
        company_value = 'Total Investment:',
        invest = 'Invest',
        amount = 'Amount',
        dissolve = 'Dissolve',
        cost = 'Cost: ',

        job_header = 'Employment Opportunities',
        job_text = 'Apply For A New Job',
        job_apply_header = 'Are You Sure?',
        job_apply_text = 'Warning if you are Currently Employed You Will Lose your Current Job By Applying For A Different One!',
        job_pay_per_hour = 'Estimated Per Hour',
        
        register_company_header = 'Register Company',
        register_company_text = 'Register your company and become a legitimate business and enjoy all the perks that come with it! No Longer worry about the IRS being concerned about your funds or large deposits, enjoy investing in your company to grow your empire and expand your business today!',
        register_company_name_header = 'Enter Company Name',
        register_company_dissolve_header = 'Dissolve Company',
        register_company_dissolve_text = 'Are you sure you want to dissolve your company %{name}?, <br><br>Warning You will loose all your investments!',
        register_company_edit_header = 'Edit Company',
        register_company_edit_name_header = 'Change Company Name',
        register_company_edit_type_header = 'Change Company Type',
        register_company_edit_text = 'Here you can edit your Company\'s Name and Type!',
        register_company_edit_name = 'Company Name',
        register_company_edit_type = 'Company Type',
        register_company_edit_name_confirm_text = 'Are you sure you want to change your Company\'s name to %{name}?',
        register_company_edit_type_confirm_text = 'Are you sure you want to change your Company\'s type to %{type}?',
        register_company_invest_header = 'Invest Into Company',
        register_company_invest_text = 'Invest in your company and help grow your profit margins today! Remember the more you invest the you could make!',
        register_company_invest_amount_header = 'Amount To Invest',
        register_company_invest_confirm_header = 'Are You Sure?',
        register_company_invest_confirm_text = 'You are about to invest the amount below in to %{name} are you sure you\'d like to invest?',
        register_company_invest_amount = 'Amount: ',
        register_company_invest_current = 'Current Investment: ',
        register_company_name_input = 'Company Name',
        register_company_type_input = 'Company Type',
        owned_company_header = 'Companies',
        owned_company_text = 'You ready to become a boss?',
        owned_company_owner = 'Owner: %{firstname} %{lastname}',
        owned_company_purchase = 'Purchase Price: ',
        owned_company_sell= 'Sell Price: ',
        owned_company_purchase_header = 'Purchase Company',
        owned_company_purchase_text = 'Are you sure you want to purchase %{company} for $%{purchase}? You can sell the company for $%{sell} if you no longer want to own it',
        owned_company_employees = 'Employees: %{amount}',
        owned_company_sell_confirm_header = 'Selling Company',
        owned_company_sell_confirm_text = 'Warning you are about to sell your business and will lose all income and control of this business! Are you sure you want to sell %{name}?',
        owned_company_selling_price = 'Selling Price: ',
    },
    job = {
        realestate = 'Interested in real estate make that big commission today and become a realtor!',
        taxi = 'Love driving? Know the city well? Join your local cab service today!',
        bus = 'Help out your community today with their transportation needs and become a public transportation driver',
        cardealer = 'Love cars? Turn your passion into a career become a sales associate today!',
        mechanic = 'Interested in motorworks? Turn your interest into a career become a certified mechanic today!',
        reporter = 'Love keeping up with current events in your area? Become a reporter at weasel news today!',
        trucker = 'Open road calling your name? Make a living driving the state! Get your CDL today!',
        tow = 'Interest in roadside assistance? Join your local towing agency today!',
        garbage = 'This job may stink but the check doesn\'t!',
        vineyard = 'Got Taste? See if you have a refined pallet for the wine industry apply today!',
        hotdog = 'Slang them wieners and make some bread!',
    },
    company = {
        bennys = 'Benny\'s Original Motor Works allows players to fit specialized equipment and accessories to their cars in GTA Online, such as hydraulics, custom stereos, vinyls, engine and interior mods and unique paint-jobs.',
        pdm = 'Premium Deluxe Motorsport is a vehicle dealership located on Power Street and Adam\'s Apple Boulevard in Pillbox Hill, Los Santos.',
        aoki = 'Aoki Japanese Restaurant is a restaurant located on Eclipse Boulevard and serves you the best Japanese food there is'
    },
    info = {
        player_id = 'ID of Player',
        license_type = 'License Type (%{types})',
    },
    error = {
        job_not_available = 'Looks like the job is no longer available',
        license_not_allowed = 'We don\'t have any records on your name for this license',
        license_already = 'Player already has a license',
        license_not = 'Player doesn\'t have that license',
        license_type = 'Invalid license type',
        rank_license = 'You are not a high enough rank to assign a license',
        rank_remove = 'You are not a high enough rank to remove a license',
        removed_license = 'You\'ve had a license removed',
        business_license_required = 'You need a business license to purchase a company',
        already_own_company = 'You already own a company, sell your current company first before purchasing another company',
        name_length = 'Company Name needs to be between %{min} and %{max} characters',
        not_enough_money = 'You can\'t afford this',
        purchased_company = 'We can\'t located the company you are trying to purchase',
        sell_company = 'We can\'t located the company you are trying to sell',
        already_has_license = 'Looks like you already have this license',
    },
    success = {
        give_license = 'You given a license',
        given_license = 'You have been given a license',
        remove_license = 'You removed a license',
        pickup_counter = 'Your license is ready to be picked up at the counter',
        job_hired = 'Congratulations you have been offered a job at %{job}',
        registered_company = 'You registered %{name} as a company',
        registered_company_name_changed = 'You have successfully changed your company name to %{name}',
        registered_company_type_changed = 'You have successfully changed your company type to %{type}',
        registered_company_invest = 'You invested $%{amount} into your company',
        registered_company_dissolve = 'You have successfully dissolved %{name}',
        purchased_company = 'You are now the owner of %{name}',
        sell_company = 'You have sold %{name}',
    },
    commands = {
        license_give = 'Give a license to someone',
        license_remove = 'Remove a license from someone',
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})