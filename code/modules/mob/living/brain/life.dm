
/mob/living/brain/Life(seconds_per_tick = SSMOBS_DT, times_fired)
	if(isnull(loc) || HAS_TRAIT(src, TRAIT_NO_TRANSFORM))
		return
	. = ..()
	handle_emp_damage(seconds_per_tick, times_fired)

/mob/living/brain/update_stat()
	if(HAS_TRAIT(src, TRAIT_GODMODE))
		return
	if(health > HEALTH_THRESHOLD_DEAD)
		return
	if(stat != DEAD)
		death()
	var/obj/item/organ/internal/brain/BR
	if(container?.brain)
		BR = container.brain
	else if(istype(loc, /obj/item/organ/internal/brain))
		BR = loc
	if(BR)
		BR.set_organ_damage(BRAIN_DAMAGE_DEATH) //beaten to a pulp

/mob/living/brain/proc/handle_emp_damage(seconds_per_tick, times_fired)
	if(!emp_damage)
		return

	if(stat == DEAD)
		emp_damage = 0
	else
		emp_damage = max(emp_damage - (0.5 * seconds_per_tick), 0)
