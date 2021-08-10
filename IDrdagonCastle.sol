// File: contracts/IDragonCastle.sol

pragma solidity 0.6.12;

interface IDragonCastle is Ownable, ReentrancyGuard, ERC20("Dragon Castle","gDRAGON"){
    // The address of the smart chef factory
    function DRAGON_CASTLE_FACTORY external returns (address);

    // Whether a limit is set for users
    function hasUserLimit external returns (bool);

    // Whether a limit is set for the pool
    function hasPoolLimit external returns (bool);

    // Whether it is initialized
    function isInitialized external returns (bool);

    // Accrued token per share
    function accTokenPerShare(ERC20 _tokenAddress) external returns (uint256);

    // The block number when staking starts.
    function stakingBlock external returns (uint256);

    // The block number when unstaking starts.
    function unStakingBlock external returns (uint256);

    // The block number when DRAGON mining ends.
    function bonusEndBlock external returns (uint256);

    // The block number when DRAGON mining starts.
    function startBlock external returns (uint256);

    // The block number of the last pool update
    function lastRewardBlock external returns (uint256);

    // The pool limit per user (0 if none)
    function poolLimitPerUser external returns (uint256);

    // The pool cap (0 if none)
    function poolCap external returns (uint256);

    // Whether the pool's staked token balance can be remove by owner
    function isRemovable external returns (bool);

    // DRAGON tokens created per block.
    function rewardPerBlock(ERC20 _tokenAddress) external returns (uint256);

    // The precision factor
    function PRECISION_FACTOR(ERC20 _tokenAddress) external returns (uint256);

    // The reward token
    function rewardTokens() external returns (ERC20[]);

    // The staked token
    function stakedToken() external returns (ERC20);

    // Info of each user that stakes tokens (stakedToken)
    function userInfo(address _usr) external returns (UserInfo);

    struct UserInfo {
        uint256 amount; // How many staked tokens the user has provided
        mapping(ERC20 => uint256) rewardDebt; // Reward debt
    }
    
    function deposit(uint256 _amount) external; 
   
    function withdraw(uint256 _amount) external;

    function emergencyWithdraw() external;

    function emergencyRewardWithdraw(uint256 _amount) external onlyOwner;

    function recoverWrongTokens(address _tokenAddress, uint256 _tokenAmount) external onlyOwner;

    function emergencyRemoval(uint256 _amount) external onlyOwner;

    function stopReward() external onlyOwner;
    
    function updatePoolLimitPerUser(bool _hasUserLimit, uint256 _poolLimitPerUser) external onlyOwner;

    function updatePoolCap(bool _hasPoolLimit, uint256 _poolCap) external onlyOwner;

    function updateRewardPerBlock(uint256 _rewardPerBlock, ERC20 _token) external onlyOwner;

    function updateStartAndEndBlocks(uint256 _startBlock, uint256 _bonusEndBlock) external onlyOwner;

    function updateStakingBlock(uint256 _startStakingBlock) external onlyOwner;

    function updateUnStakingBlock(uint256 _startUnStakingBlock) external onlyOwner;

    function pendingReward(address _user) external view returns (uint256[] memory, ERC20[] memory);

    function pendingRewardByToken(address _user, ERC20 _token) external view returns (uint256);

    function addRewardToken(ERC20 _token, uint256 _rewardPerBlock) external onlyOwner;

    function removeRewardToken(ERC20 _token) external onlyOwner;

    function getUserDebt(address _usr) external view returns(ERC20[] memory, uint256[] memory);

    function getUserDebtByToken(address _usr, ERC20 _token) external view returns(uint256);

    function getAllRewardPerBlock(ERC20[] memory _tokens) external view returns(uint256[] memory);

    function getAllAccTokenPerShared(ERC20[] memory _tokens) external view returns(uint256[] memory);

    function getAllPreFactor(ERC20[] memory _tokens) external view returns(uint256[] memory);

    //*Override transfer functions, allowing receipts to be transferable */

    function transfer(address recipient, uint256 amount) public virtual override returns (bool);

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override returns (bool);
}