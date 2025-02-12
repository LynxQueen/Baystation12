/mob/living
	var/datum/psi_complexus/psi

/mob/living/Login()
	. = ..()
	if(psi)
		psi.update(TRUE)
		if(!psi.suppressed)
			psi.show_auras()

/mob/living/Destroy()
	QDEL_NULL(psi)
	. = ..()

/mob/living/proc/set_psi_rank(faculty, rank, take_larger, defer_update, temporary)
	if(!psi)
		if(!zone_sel)
			to_chat(src, SPAN_NOTICE("You feel something strange brush against your mind... but your brain is not able to grasp it."))
			return
		psi = new(src)
	var/current_rank = psi.get_rank(faculty)
	if(current_rank != rank && (!take_larger || current_rank < rank))
		psi.set_rank(faculty, rank, defer_update, temporary)

/mob/living/proc/deflect_psionic_attack(attacker)
	var/blocked = 100 * get_blocked_ratio(null, DAMAGE_PSIONIC)
	if(prob(blocked))
		if(attacker)
			to_chat(attacker, SPAN_WARNING("Your mental attack is deflected by \the [src]'s defenses!"))
			to_chat(src, SPAN_DANGER("\The [attacker] strikes out with a mental attack, but you deflect it!"))
		return TRUE
	return FALSE
