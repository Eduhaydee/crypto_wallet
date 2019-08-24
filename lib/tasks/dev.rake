namespace :dev do
  desc "Config environment development"
  task setup: :environment do
    if Rails.env.development?
      show_spinner('Drop DB...') { %x(rails db:drop) }
      show_spinner('Create DB...') { %x(rails db:create) }
      show_spinner('Loading DB Migrate...') { %x(rails db:migrate) }
      %x(rails dev:add_mining_types)
      %x(rails dev:add_coins)
    else
      'You are not in development mode'
    end
  end

  desc "Add Coins"
  task add_coins: :environment do
    show_spinner('Create Coins...') do
      coins = [
          { description: 'Bitcoin',
            acronym: 'BTC',
            url_image: 'https://cdn.shopify.com/s/files/1/1170/3026/products/bitcoin_store_sticker_a9034619-ef9c-48bf-ae64-ea646f732201_480x.png?v=1501491448',
            mining_type: MiningType.find_by(acronym: 'PoW')
          },

          { description: 'Ethereum',
            acronym: 'ETH',
            url_image: 'https://d2a4hncphh3gxw.cloudfront.net/image/artwork/40311/89/23/89231ba1d7cd720fb5d00106b33bf9db_40311',
            mining_type: MiningType.all.sample
          },

          { description: 'Dash',
            acronym: 'DASH',
            url_image: 'https://ih0.redbubble.net/image.565893645.7574/ap,550x550,12x12,1,transparent,t.u2.png',
            mining_type: MiningType.all.sample
          },

          { description: 'Iota',
            acronym: 'IOT',
            url_image: 'https://s2.coinmarketcap.com/static/img/coins/200x200/1720.png',
            mining_type: MiningType.all.sample
          },

          { description: 'ZCash',
            acronym: 'ZEC',
            url_image: 'https://z.cash/wp-content/uploads/2019/03/zcash-icon-fullcolor.png',
            mining_type: MiningType.all.sample
          }
        ]

      coins.each do |coin|
        Coin.find_or_create_by!(coin)
      end
    end
  end

  desc "Create Mining Types"
  task add_mining_types: :environment do
    show_spinner('Create Mining Types...') do
      mining_types = [
        {description: 'Proof of Work', acronym: 'PoW'},
        {description: 'Proof of Stake', acronym: 'PoS'},
        {description: 'Proof of Capacity', acronym: 'PoC'}
      ]
      mining_types.each do |mining_type|
        MiningType.find_or_create_by!(mining_type)
      end
    end
  end

  private
  def show_spinner(msg_start, msg_end = 'Done Successful!')
    spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
    spinner.auto_spin
    yield
    spinner.success("(#{msg_end})")
  end
end
