class RescueJsonParseErrors
  def initialize(app)
    @app = app
  end

  def call(env)
    @app.call(env)
  rescue ActionDispatch::ParamsParser::ParseError => _e
    [
      400, { 'Content-Type' => 'application/json' },
      [{ errors: [{ msg: '正しい入力形式で送信してください。' }] }.to_json]
    ]
  end
end
