module API
  class Root < Grape::API
    # http://localhost:3000/api/
    prefix 'api'
    mount API::Ver1::Root
    #mount Services::PokerAPI
    add_swagger_documentation
    # api/ver1/rootを認識させて使えるようにする
  end
end
