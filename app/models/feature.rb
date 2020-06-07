class Feature
  FLAGS = [
    UPGRADE = 'UPGRADE'.freeze
  ].freeze

  def self.enabled?(feature_name)
    Forty.config.features[feature_name]
  end
end
