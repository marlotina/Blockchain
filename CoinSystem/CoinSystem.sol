pragma solidity ^0.4.17;


contract CoinSytem {

    struct Customer{
        string name;
        address addr;
        uint totalEvaluation;
        uint effort;
    }

    string public name = "points";
    string public symbol = "P";
    uint etherPerPoint = 0.5e18;

    mapping(address => Customer) public customersMapping;
    address[] public customers;

    event UpdateEvaluation(address indexed customer, uint evaluationPoints);
    event AddedCustomer(address indexed newMember);
    event AddEffort(address indexed customer, uint effort);

    address public owner;
    
    function CoinSytem() public{
        owner = msg.sender;
    }

    function newCustomer(string name) public {
        Customer storage customer = customersMapping[msg.sender];
        customer.name = name;
        customer.addr = msg.sender;

        customers.push(customer.addr);

        AddedCustomer(msg.sender);
    }

    function getCustomer(string name) public view returns(string customerName, 
            uint totalEvaluation, uint points)
    {        
        Customer memory customer = Customer("",0x0,0,0);

        for(uint i = 0; i < customers.length; i++){
            Customer memory current = customersMapping[customers[i]];
            if(keccak256(current.name) == keccak256(name)){
                customer = current;
                break;
            }
        }

        return (customer.name, customer.totalEvaluation, customer.effort);
    }

    function AddEvaluation(uint evaluation) public {
        //require(msg.value == 20 ether);
        Customer storage customer = customersMapping[msg.sender];
        customer.totalEvaluation += evaluation;

        if(evaluation > 7){
            customer.totalEvaluation += 5;
        }        
        
        UpdateEvaluation(msg.sender, 2);
    }

    function BuyPoints(uint effort) public payable{
        require(msg.value > 0 ether);
        Customer storage customer = customersMapping[msg.sender];
        customer.effort += effort;
        
        AddEffort(msg.sender, 2);
    }
}