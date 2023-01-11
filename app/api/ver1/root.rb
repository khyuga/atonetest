module Ver1
  class Root < Grape::API
    # これでdomain/api/v1でアクセス出来るようになる。(versioning)
    version 'v1', using: :path
    format :json

    default_format :json
    content_type :json, "application/json"
    content_type :xml, 'application/xml'
    content_type :javascript, 'application/javascript'
    content_type :txt, 'text/plain'
    content_type :html, 'text/html'

    rescue_from Grape::Exceptions::Base do |e|
      error!({ errors: [{ msg: "正しい入力形式で送信してください。" }] }, 400)
    end

    mount Ver1::Cards
  end
end

