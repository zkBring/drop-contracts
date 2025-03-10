// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.17;

import "../interfaces/ILinkdropERC20.sol";
import "./LinkdropFactoryCommon.sol";
import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";

contract LinkdropFactoryERC20 is LinkdropFactoryCommon {

    /**
    * @dev Function to verify claim params, make sure the link is not claimed or canceled and proxy has sufficient balance
    * @param _tokenAddress Token address
    * @param _tokenAmount Amount of tokens to be claimed (in atomic value)
    * @param _expiration Unix timestamp of link expiration time
    * @param _linkId Address corresponding to link key
    * @param _linkdropMaster Address corresponding to linkdrop master key
    * @param _campaignId Campaign id
    * @param _linkdropSignerSignature ECDSA signature of linkdrop signer
    * @param _receiver Address of linkdrop receiver
    * @param _receiverSignature ECDSA signature of linkdrop receiver
    * @return True if success
    */
    function checkClaimParams
    (
        address _tokenAddress,
        uint _tokenAmount,
        uint _expiration,
        address _linkId,
        address _linkdropMaster,
        uint _campaignId,
        bytes memory _linkdropSignerSignature,
        address _receiver,
        bytes memory _receiverSignature
    )
    public
    view
    returns (bool)
    {
        // Make sure proxy contract is deployed
        require(isDeployed(_linkdropMaster, _campaignId), "LINKDROP_PROXY_CONTRACT_NOT_DEPLOYED");

        return ILinkdropERC20(deployed[salt(_linkdropMaster, _campaignId)]).checkClaimParams
        (
            _tokenAddress,
            _tokenAmount,
            _expiration,
            _linkId,
            _linkdropSignerSignature,
            _receiver,
            _receiverSignature
        );
    }

    /**
    * @dev Function to claim ETH and/or ERC20 tokens
    * @param _tokenAddress Token address
    * @param _tokenAmount Amount of tokens to be claimed (in atomic value)
    * @param _expiration Unix timestamp of link expiration time
    * @param _linkId Address corresponding to link key
    * @param _linkdropMaster Address corresponding to linkdrop master key
    * @param _campaignId Campaign id
    * @param _linkdropSignerSignature ECDSA signature of linkdrop signer
    * @param _receiver Address of linkdrop receiver
    * @param _receiverSignature ECDSA signature of linkdrop receiver
    * @return True if success
    */
    function claim
    (
        address _tokenAddress,
        uint _tokenAmount,
        uint _expiration,
        address _linkId,
        address _linkdropMaster,
        uint _campaignId,
        bytes calldata _linkdropSignerSignature,
        address _receiver,
        bytes calldata _receiverSignature
    )
    external
    returns (bool)
    {
        // Make sure proxy contract is deployed
        require(isDeployed(_linkdropMaster, _campaignId), "LINKDROP_PROXY_CONTRACT_NOT_DEPLOYED");

        // Call claim function in the context of proxy contract
        ILinkdropERC20(deployed[salt(_linkdropMaster, _campaignId)]).claim
          (
           _tokenAddress,
           _tokenAmount,
           _expiration,
            _linkId,
           _linkdropSignerSignature,
           _receiver,
           _receiverSignature
           );
          
          return true;
    }   
}
