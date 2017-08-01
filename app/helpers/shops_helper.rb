module ShopsHelper
  def format_skill(skill)
    case skill
    when 'MELEE'
      'Melee'
    when 'BRAWL'
      'Brawl'
    when 'GUNN'
      'Gunnery'
    when 'RANGLT'
      'Ranged Light'
    when 'RANGHVY'
      'Ranged Heavy'
    when 'LTSABER'
      'Lightsaber'
    when 'MECH'
      'Mechanics'
    end
  end

  def format_qualities(qualities)
    qualities[0] = case qualities[0]
                   when 'STUNSETTING'
                     'Stun Setting'
                   when 'VICIOUSDROID'
                     'Vicious Droid'
                   when 'SLOWFIRING'
                     'Slow Firing'
                   when 'STUNDAMAGEDROID'
                     'Stun Damage Droid'
                   when 'STUNDAMAGE'
                     'Stun Damage'
                   when 'LIMITEDAMMO'
                     'Limited Ammo'
                   else
                     qualities[0].titleize
                   end
    qualities.join(' - ')
  end

  def dice_display(dice_pool)
    dice = []
    dice_pool.each do |dice_type, amount|
      amount.times { dice << image_tag("#{dice_type.gsub('_dice', '')}.svg", width: 15) }
    end
    dice.join.html_safe
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
      '[BO]'         => image_tag('boost.svg', width: 15)
    }.freeze

    results = description.scan(/(\[(?:\[??[^\[]*?\]))/).flatten.uniq

    results.each do |result|
      description.gsub!(result, types[result])
    end
    description.html_safe
  end
end
