class Feature
  FLAG_NAME_MAP = {
    sanity: 'FEATURE_SANITY',
    upgrade: 'FEATURE_UPGRADE'
  }.freeze

  class UnknownFeatureFlag < StandardError; end

  def self.enabled?(feature_name)
    raise UnknownFeatureFlag unless FLAG_NAME_MAP.keys.include?(feature_name)

    flag_name = FLAG_NAME_MAP[feature_name]
    flag_value = ENV[flag_name] || 'disabled'
    flag_value == 'enabled'
  end
end
