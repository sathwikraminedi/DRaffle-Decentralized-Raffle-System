module MyModule::DRaffle2 {
    use std::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use std::vector;
    use aptos_framework::timestamp;
    use std::string::String;
    use std::option::{Self, Option};

    /// Custom errors
    const ENOT_ADMIN: u64 = 1;
    const ELOTTERY_ALREADY_EXISTS: u64 = 2;
    const ELOTTERY_NOT_ACTIVE: u64 = 3;
    const EINSUFFICIENT_BALANCE: u64 = 4;
    const ELOTTERY_ALREADY_DRAWN: u64 = 5;
    const ENO_PARTICIPANTS: u64 = 6;
    const ESTORE_NOT_INITIALIZED: u64 = 7;

    const ADMIN_ADDRESS: address = @0x791bb225d446fad68fb3aab4da12f8d58561f8291765c13b139e5921a68680e7;
    const SECONDS_PER_DAY: u64 = 86400;
    const MICRO_SECONDS_PER_DAY: u64 = 86400000000;

    struct LotteryInfo has store, drop, copy {
        lottery_id: u64,
        lottery_name: String,
        admin: address,
        ticket_price: u64,
        win_amount: u64,
        participants: vector<address>,
        is_active: bool,
        winner: Option<address>,
        start_time: u64,
        end_time: Option<u64>,
        duration_days: u64,
        description: String
    }

    struct LotteryStore has key {
        active_lotteries: vector<LotteryInfo>,
        past_lotteries: vector<LotteryInfo>,
        total_lotteries: u64,
    }

    fun init_module(admin: &signer) {
        assert!(signer::address_of(admin) == ADMIN_ADDRESS, ENOT_ADMIN);
        
        if (!exists<LotteryStore>(ADMIN_ADDRESS)) {
            move_to(admin, LotteryStore {
                active_lotteries: vector::empty(),
                past_lotteries: vector::empty(),
                total_lotteries: 0,
            });
        };
    }

    public entry fun initialize_lottery(
        admin: &signer,
        lottery_name: String,
        ticket_price: u64,
        win_amount: u64,
        duration_days: u64,
        description: String
    ) acquires LotteryStore {
        let admin_address = signer::address_of(admin);
        assert!(admin_address == ADMIN_ADDRESS, ENOT_ADMIN);
        assert!(exists<LotteryStore>(admin_address), ESTORE_NOT_INITIALIZED);

        let store = borrow_global_mut<LotteryStore>(admin_address);
        store.total_lotteries = store.total_lotteries + 1;
        
        let new_lottery = LotteryInfo {
            lottery_id: store.total_lotteries,
            lottery_name,
            admin: admin_address,
            ticket_price,
            win_amount,
            participants: vector::empty(),
            is_active: true,
            winner: option::none(),
            start_time: timestamp::now_microseconds(),
            end_time: option::none(),
            duration_days,
            description
        };

        vector::push_back(&mut store.active_lotteries, new_lottery);
    }

    fun get_lottery_by_id(lotteries: &vector<LotteryInfo>, lottery_id: u64): Option<u64> {
        let i = 0;
        let len = vector::length(lotteries);
        while (i < len) {
            let lottery = vector::borrow(lotteries, i);
            if (lottery.lottery_id == lottery_id) {
                return option::some(i)
            };
            i = i + 1;
        };
        option::none()
    }

    public entry fun buy_ticket(
        buyer: &signer,
        lottery_id: u64
    ) acquires LotteryStore {
        let store = borrow_global_mut<LotteryStore>(ADMIN_ADDRESS);
        let lottery_index_opt = get_lottery_by_id(&store.active_lotteries, lottery_id);
        assert!(option::is_some(&lottery_index_opt), ELOTTERY_NOT_ACTIVE);
        
        let lottery_index = option::extract(&mut lottery_index_opt);
        let lottery = vector::borrow_mut(&mut store.active_lotteries, lottery_index);
        let buyer_addr = signer::address_of(buyer);
        
        assert!(lottery.is_active, ELOTTERY_NOT_ACTIVE);
        assert!(
            coin::balance<AptosCoin>(buyer_addr) >= lottery.ticket_price,
            EINSUFFICIENT_BALANCE
        );
        
        coin::transfer<AptosCoin>(
            buyer,
            lottery.admin,
            lottery.ticket_price
        );
        
        vector::push_back(&mut lottery.participants, buyer_addr);
    }

    public entry fun draw_winner(
        admin: &signer,
        lottery_id: u64
    ) acquires LotteryStore {
        let admin_address = signer::address_of(admin);
        assert!(admin_address == ADMIN_ADDRESS, ENOT_ADMIN);
        
        let store = borrow_global_mut<LotteryStore>(admin_address);
        let lottery_index_opt = get_lottery_by_id(&store.active_lotteries, lottery_id);
        assert!(option::is_some(&lottery_index_opt), ELOTTERY_NOT_ACTIVE);
        
        let lottery_index = option::extract(&mut lottery_index_opt);
        let lottery = vector::borrow_mut(&mut store.active_lotteries, lottery_index);
        
        assert!(lottery.is_active, ELOTTERY_NOT_ACTIVE);
        assert!(!vector::is_empty(&lottery.participants), ENO_PARTICIPANTS);
        assert!(option::is_none(&lottery.winner), ELOTTERY_ALREADY_DRAWN);

        let participants_length = vector::length(&lottery.participants) as u64;
        let current_timestamp = timestamp::now_microseconds();
        let winner_index = current_timestamp % participants_length;
        let winner = *vector::borrow(&lottery.participants, winner_index);

        coin::transfer<AptosCoin>(admin, winner, lottery.win_amount);
        
        lottery.winner = option::some(winner);
        lottery.is_active = false;
        lottery.end_time = option::some(current_timestamp);

        // Move lottery from active to past
        let finished_lottery = *lottery;
        vector::remove(&mut store.active_lotteries, lottery_index);
        vector::push_back(&mut store.past_lotteries, finished_lottery);
    }

    #[view]
    public fun get_active_lotteries(): vector<LotteryInfo> acquires LotteryStore {
        *&borrow_global<LotteryStore>(ADMIN_ADDRESS).active_lotteries
    }

    #[view]
    public fun get_past_lotteries(): vector<LotteryInfo> acquires LotteryStore {
        *&borrow_global<LotteryStore>(ADMIN_ADDRESS).past_lotteries
    }

    #[view]
    public fun get_all_lotteries(): (vector<LotteryInfo>, vector<LotteryInfo>) acquires LotteryStore {
        let store = borrow_global<LotteryStore>(ADMIN_ADDRESS);
        (*&store.active_lotteries, *&store.past_lotteries)
    }

    #[view]
    public fun get_lottery_by_id_full(lottery_id: u64): Option<LotteryInfo> acquires LotteryStore {
        let store = borrow_global<LotteryStore>(ADMIN_ADDRESS);
        
        // First check active lotteries
        let active_index_opt = get_lottery_by_id(&store.active_lotteries, lottery_id);
        if (option::is_some(&active_index_opt)) {
            let index = option::extract(&mut active_index_opt);
            return option::some(*vector::borrow(&store.active_lotteries, index))
        };
        
        // Then check past lotteries
        let past_index_opt = get_lottery_by_id(&store.past_lotteries, lottery_id);
        if (option::is_some(&past_index_opt)) {
            let index = option::extract(&mut past_index_opt);
            return option::some(*vector::borrow(&store.past_lotteries, index))
        };
        
        option::none()
    }

    #[view]
    public fun get_total_lotteries(): u64 acquires LotteryStore {
        borrow_global<LotteryStore>(ADMIN_ADDRESS).total_lotteries
    }
}