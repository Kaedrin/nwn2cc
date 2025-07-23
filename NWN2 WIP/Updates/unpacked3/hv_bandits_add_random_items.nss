
const int COMMON_CHANCE = 50; //50% chance for each item from the old, original bandit stock to appear
const int EXOTIC_CHANCE = 20; // 20% for each "exotic" item to appear
const int RARE_CHANCE = 10; // 10% chance for rare (comparatively more powerful items) to appear
const int MAX_STACKS = 3; //Maximum possible number of "old items" that could show up per reset


void main()
{
	object store = GetObjectByTag("hv_bandits_store");
	
	/*
	int COMMON_CHANCE = GetGlobalInt("bandits_store_chance");
	if (COMMON_CHANCE == 0) {
		COMMON_CHANCE = 100;
	}
	*/
	
	// remove current items
	object item = GetFirstItemInInventory(store);
	while (item != OBJECT_INVALID) {
	
		DestroyObject(item);
		item = GetNextItemInInventory(store);
	}
	
	int rand;
	
	// new items
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_unw_gax2", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_wswmgs004", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <=EXOTIC_CHANCE) {
		CreateItemOnObject("n2_wdbnqs001", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_wdbmqs005", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_unw_bst2", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_unw_bst1", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_unw_clb2", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_unw_dwa3", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_wblmfl007", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_wspmka001", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_unw_mac3", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_unw_ssw2", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_wblmhw010", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_wbwmln006", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_unw_sbw1", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_wbwmsh006", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_wbwmsl007", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_wbwmsl006", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nx1_pca_redwizard", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_maarcl002", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_itset_rgr1", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_maarcl014", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_itset_pal3", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("x0_ashmlw003", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_ashmlw005", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_ashmto003", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("x0_it_mring007", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("x0_it_mneck004", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= RARE_CHANCE) {
		CreateItemOnObject("n2_itset_brd3", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_helm_finch", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_armhe012", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("nw_armhe009", store, 1);
	}
	
	rand = Random(100) + 1;
	if (rand <= EXOTIC_CHANCE) {
		CreateItemOnObject("n2_itset_clr1", store, 1);
	}
	
	// old items
	int stack_count;
	for (stack_count = 0; stack_count < MAX_STACKS; stack_count++) //Many items can only stack once, this loop allows for the creation of up to "max_stack" items per reset
	{
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_belt002", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_helmet001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_belt001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_belt005", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_cloak001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_cloak002", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_tshield001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_hshield001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_lshield001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_belt003", store, 1);
		}
		
		// scrolls - stack of 10
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_sparscr603", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_sparscr801", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_sparscr502", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x1_it_spdvscr804", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("n2_it_sparscr008", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_sparscr803", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("n2_it_sparscr015", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_sparscr906", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_sparscr802", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_sparscr805", store, 10);
		}
		// end scrolls
		
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_amulet001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_amulet002", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_amulet003", store, 1);
		}
		
		// poisons stack of 10
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_poison019", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_poison044", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_poison015", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_poison020", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_poison038", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_poison014", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_poison026", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_poison021", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_poison039", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_poison015", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_poison027", store, 10);
		}
		// end poisons
		
		// potions stack of 10
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_mpotion012", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_it_mpotion001", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_mpotion002", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("x2_it_mpotion002", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_mpotion010", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_it_mpotion001", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_mpotion017", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_mpotion008", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_it_mpotion004", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_it_mpotion011", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_it_mpotion041", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_mpotion019", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_mpotion018", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nw_it_mpotion004", store, 10);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("nx1_it_mpotion010", store, 10);
		}
		// end potions
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_ring002", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_ring001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_ring003", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_lbow001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_sbow001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_hc001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_lhammer001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_club001", store, 1);
		}
		
		rand = Random(100) + 1;
		if (rand <= COMMON_CHANCE) {
			CreateItemOnObject("hv_b_mstar001", store, 1);
		}
	}
}