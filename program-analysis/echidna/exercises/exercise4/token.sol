contract Ownership {
    address owner = msg.sender;

    function Owner() public {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(owner == msg.sender);
        _;
    }
}

contract Pausable is Ownership {
    bool is_paused;

    modifier ifNotPaused() {
        require(!is_paused);
        _;
    }

    function paused() public isOwner {
        is_paused = true;
    }

    function resume() public isOwner {
        is_paused = false;
    }
}

contract Token is Pausable {
    mapping(address => uint256) public balances;

    function transfer(address to, uint256 value) public ifNotPaused {
        uint256 sender_initial_balance = balances[msg.sender];
        uint256 to_initial_balace = balances[to];
        require(sender_initial_balance >= value);
        balances[msg.sender] -= value;
        balances[to] += value;
        assert(balances[msg.sender] <= sender_initial_balance);
        assert(balances[to] >= to_initial_balace);
    }
}
