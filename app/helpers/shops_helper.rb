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
      amount.times { dice << image_tag("dice/#{dice_type.gsub('_dice', '')}.png") }
    end
    dice.join.html_safe
  end
end
