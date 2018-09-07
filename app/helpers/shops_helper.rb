module ShopsHelper
  SKILLS = {
    'MELEE'   => 'Melee',
    'BRAWL'   => 'Brawl',
    'GUNN'    => 'Gunnery',
    'RANGLT'  => 'Ranged Light',
    'RANGHVY' => 'Ranged Heavy',
    'LTSABER' => 'Lightsaber',
    'MECH'    => 'Mechanics'
  }.freeze

  QUALITIES = {
    'STUNSETTING'     => 'Stun Setting',
    'VICIOUSDROID'    => 'Vicious Droid',
    'SLOWFIRING'      => 'Slow Firing',
    'STUNDAMAGEDROID' => 'Stun Damage Droid',
    'STUNDAMAGE'      => 'Stun Damage',
    'LIMITEDAMMO'     => 'Limited Ammo'
  }.freeze

  def format_skill(skill)
    SKILLS.dig(skill)
  end

  def format_qualities(qualities)
    qualities[0] = QUALITIES.fetch(qualities[0], qualities[0].titleize)
    qualities.join(' - ')
  end

  def dice_display(dice_pool)
    dice = []
    dice_pool.each do |dice_type, amount|
      amount.times { dice << image_tag("#{dice_type.to_s.gsub('_dice', '')}.svg", width: 15) }
    end
    dice.join.html_safe
  end

  def roll_results(dice)
    dice_images = [
      ['success.svg', 'failure.svg'],
      ['advantage.svg', 'threat.svg'],
      ['triumph.svg', 'dispair.svg']
    ].freeze

    dice.each_with_index.map do |d, i|
      image_type = d.positive? ? 0 : 1
      Array.new(d.abs).map { image_tag(dice_images[i][image_type], width: 25) }
    end.join.html_safe
  end

  def format_description(description)
    return if description.nil?
    types = {
      '[-]'          => '[-]',
      '[I]'          => '<i>',
      '[i]'          => '</i>',
      '[B]'          => '<b>',
      '[b]'          => '</b>',
      '[TH]'         => image_tag('threat.svg', width: 15),
      '[THREAT]'     => image_tag('threat.svg', width: 15),
      '[TR]'         => image_tag('triumph.svg', width: 15),
      '[SE]'         => image_tag('setback.svg', width: 15),
      '[SETBACK]'    => image_tag('setback.svg', width: 15),
      '[AD]'         => image_tag('advantage.svg', width: 15),
      '[ADVANTAGE]'  => image_tag('advantage.svg', width: 15),
      '[DE]'         => image_tag('dispair.svg', width: 15),
      '[DESPAIR]'    => image_tag('dispair.svg', width: 15),
      '[CH]'         => image_tag('challenge.svg', width: 15),
      '[DI]'         => image_tag('difficulty.svg', width: 15),
      '[DIFFICULTY]' => image_tag('difficulty.svg', width: 15),
      '[BOOST]'      => image_tag('boost.svg', width: 15),
      '[BO]'         => image_tag('boost.svg', width: 15),
      '[SU]'         => image_tag('success.svg', width: 15),
      '[SUCCESS]'    => image_tag('success.svg', width: 15),
      '[FAILURE]'    => image_tag('failure.svg', width: 15),
      '[FA]'         => image_tag('failure.svg', width: 15),
      '[PR]'         => image_tag('proficiency.svg', width: 15),
      '[AB]'         => image_tag('ability.svg', width: 15),
      '[FO]'         => image_tag('force.svg', width: 15),
      '[FP]'         => image_tag('force_pip.svg', width: 15),
      '[DA]'         => image_tag('dark_pip.svg', width: 15),
      '[FORCEPOINT]' => image_tag('force_pip.svg', width: 15)
    }.freeze

    results = description.scan(/(\[(?:\[??[^\[]*?\]))/).flatten.uniq

    results.each do |result|
      description.gsub!(result, types[result])
    end
    description.html_safe
  end

  def list_sources(description, sources)
    meta = []
    sources.each do |source|
      regex = /page (\d*) of the #{source}/
      matches = description.match(regex)
      next if matches.nil?
      meta << { page: matches[1], sourcebook: source }
    end
    meta
  end
end
