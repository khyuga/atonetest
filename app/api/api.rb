module API
  class Root < Grape::API
    prefix 'api'
    mount API::Ver1::Root
    mount Services::PokerAPI
  end
end
