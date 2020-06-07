class Feature
  FLAGS = [].freeze

  def self.enabled?(feature_name)
    Forty.config.features[feature_name]
  end
end
