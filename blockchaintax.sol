pragma solidity ^0.4.20;


contract Organization{
    address public orgidentifier;
    string public orgname;
    uint  public amount;
    int[]   public  transactions;
    uint  public TAN_ID;
    enum StateType {CREATEORG,TRASACT}
    StateType public  State;
    constructor(string org_name,uint TAN) public
{
        orgidentifier=msg.sender;
        orgname =org_name;
        TAN_ID-TAN;
        amount=0;
        State = StateType.TRASACT;

}

function updateamount(uint newvalue) {
    amount=amount+newvalue;
    State = StateType.TRASACT;
}

function addtransaction(address txnid){
    transactions.push(int(txnid));
    State = StateType.TRASACT;
}
function Gettransactions() public constant returns (int[]) {
     return transactions;
}


}

contract Transaction{
    address    public  from;
    address   public   to ;
    uint public amount;
    string public  transaction_description;
enum    StateType      {CREATE,TRANSACT}
StateType  public    State;

constructor(address from_entity,string transaction_des,uint value){
from=from_entity;
transaction_description=transaction_des;
amount=value;
State = StateType.TRANSACT;
}

function accepted_toentity(address to_entity)
{
     to=to_entity;
     State = StateType.TRANSACT;
}
function getamount() public  returns (uint) {
     return amount;
}
}

contract Customer{
    address public  customerid;
    string public  Customer_Info;
     uint  public amount;
    int[]   public  transactions;
    uint public pan_id;
    enum StateType {CREATE,TRANSACT}
     StateType public  State;

     constructor (uint pan,string CustomerInfo){
         customerid=msg.sender;
         Customer_Info=CustomerInfo;
         pan_id=pan;
         amount=0;
         State = StateType.TRANSACT;

     }
function updateamount(uint newvalue) {
    amount=amount+newvalue;
    State = StateType.TRANSACT;
}

function addtransaction(address txnid){
    transactions.push(int(txnid));
}

function Gettransactions() public constant returns (int[]) {
     return transactions;
}


}


contract blockchaintax {

     enum StateType {ORGANIZATIONCREATED,TRANSACT}
      StateType public  State;
    
    address public organization;
    address public customer;
    address public transaction;

constructor(string org_name,uint tan) public
{
      
      Organization t2=new Organization(org_name,tan);
      organization=t2;
      State = StateType.TRANSACT;
}

    function intiatetransact(string transaction_des ,uint value){
        Transaction t1=new Transaction(organization,transaction_des,value);
        transaction=t1;
        Organization o1=Organization(organization);
        o1.addtransaction(transaction);
        o1.updateamount(value);
        State = StateType.TRANSACT;

    }
    function accepttransaction(uint pan ,string Customer_Info){
        uint newamount;
        Customer c=new Customer(pan,Customer_Info);
        customer=c;
        Transaction t2=Transaction(transaction);
        t2.accepted_toentity(customer);
        Customer c3=Customer(customer);
        c3.addtransaction(transaction);
        newamount=t2.getamount();
        c3.updateamount(newamount);


            }

}

   
