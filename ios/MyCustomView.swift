//
//  MyCustomView.swift
//  fleetTest
//
//  Created by jesus vega on 12/08/22.
//

import UIKit

import ServiceCore
import ServiceChat

class MyCustomView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
  @objc var status = false {
      didSet {
          self.setupView()
      }
  }
   
  @objc var onClick: RCTBubblingEventBlock?
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
      print("native event:  native on click")
      if let config = SCSChatConfiguration(liveAgentPod: "d.la1-c1cs-ia2.salesforceliveagent.com",
                                           orgId: "00D63000000MoTt",
                                           deploymentId: "57263000000Clar",
                                           buttonId: "57363000000CmJy") {

        // Start the session
        print("native event:  on config")
        
        /*let companyField = SCSPrechatObject(label: "CompanyId", value: "00001")
        let usernameField = SCSPrechatObject(label: "Username", value: "jvega")
        let nameField = SCSPrechatObject(label: "FullName", value: "Jesus Vega")
        let dealerField = SCSPrechatObject(label: "Dealer", value: "tso")
        let emailField = SCSPrechatObject(label: "email", value: "jvega@tsomobile.com")
        let prechatFields: [SCSPrechatObject] = [companyField,usernameField,nameField,dealerField,emailField]
        config.prechatFields = prechatFields
        let contactEntity = SCSPrechatEntity(entityName: "Contact")
        contactEntity.saveToTranscript = "Contact"
        contactEntity.linkToEntityName = "Case"
        contactEntity.linkToEntityField = "ContactId"
        
        let companyEntityField = SCSPrechatEntityField(fieldName: "CompanyId", label: "CompanyId")
        companyEntityField.doFind = true
        companyEntityField.isExactMatch = true
        companyEntityField.doCreate = true
        contactEntity.entityFieldsMaps.add(companyEntityField)
        
        let usernameEntityField = SCSPrechatEntityField(fieldName: "Username", label: "Username")
        usernameEntityField.doFind = true
        usernameEntityField.isExactMatch = true
        usernameEntityField.doCreate = true
        contactEntity.entityFieldsMaps.add(usernameEntityField)
        
        let fullNameEntityField = SCSPrechatEntityField(fieldName: "FullName", label: "FullName")
        fullNameEntityField.doFind = true
        fullNameEntityField.isExactMatch = true
        fullNameEntityField.doCreate = true
        contactEntity.entityFieldsMaps.add(fullNameEntityField)
        
        let dealerEntityField = SCSPrechatEntityField(fieldName: "Dealer", label: "Dealer")
        dealerEntityField.doFind = true
        dealerEntityField.isExactMatch = true
        dealerEntityField.doCreate = true
        contactEntity.entityFieldsMaps.add(dealerEntityField)
        
        config.prechatEntities = [contactEntity]*/
        
        // Add some required fields
        // Create some basic pre-chat fields (with user input)
        
        let firstNameField = SCSPrechatObject(label: "First Name", value:"Jesus" )
        //firstNameField!.isRequired = true
        let lastNameField = SCSPrechatObject(label: "Last Name", value:"Vega")
        //lastNameField!.isRequired = true
        let emailField = SCSPrechatObject(label: "Email", value:"ventas.javc@gmail.com")
        
        let accountNameField = SCSPrechatObject(label: "Account Name", value:"uataccount")
        //emailField!.isRequired = true
        //emailField!.keyboardType = .emailAddress
        //emailField!.autocorrectionType = .no

        // Create a pre-chat field without user input
        let subjectField = SCSPrechatObject(label: "Subject", value: "Cloud Mobile Chat Session - uataccount")

        // Create an entity mapping for a Contact record type
        let contactEntity = SCSPrechatEntity(entityName: "Contact")
        contactEntity.saveToTranscript = "Contact"
        contactEntity.linkToEntityName = "Case"
        contactEntity.linkToEntityField = "ContactId"

        // Add some field mappings to our Contact entity
        let firstNameEntityField = SCSPrechatEntityField(fieldName: "FirstName", label: "First Name")
        firstNameEntityField.doFind = true
        firstNameEntityField.isExactMatch = true
        firstNameEntityField.doCreate = true
        contactEntity.entityFieldsMaps.add(firstNameEntityField)
        let lastNameEntityField = SCSPrechatEntityField(fieldName: "LastName", label: "Last Name")
        lastNameEntityField.doFind = true
        lastNameEntityField.isExactMatch = true
        lastNameEntityField.doCreate = true
        contactEntity.entityFieldsMaps.add(lastNameEntityField)
        let emailEntityField = SCSPrechatEntityField(fieldName: "Email", label: "Email")
        emailEntityField.doFind = true
        emailEntityField.isExactMatch = true
        emailEntityField.doCreate = true
        contactEntity.entityFieldsMaps.add(emailEntityField)
        

        // Create an entity mapping for a Case record type
        let caseEntity = SCSPrechatEntity(entityName: "Case")
        caseEntity.saveToTranscript = "Case"
        caseEntity.showOnCreate = true

        // Add one field mappings to our Case entity
        let subjectEntityField = SCSPrechatEntityField(fieldName: "Subject", label: "Subject")
        subjectEntityField.doCreate = true
        caseEntity.entityFieldsMaps.add(subjectEntityField)

        // Update config object with the pre-chat fields
        config.prechatFields =
          [firstNameField, lastNameField, emailField, accountNameField, subjectField] as? [SCSPrechatObject]

        // Update config object with the entity mappings
        config.prechatEntities = [contactEntity, caseEntity]

        config.visitorName = "jvega@tsomobile.com"
        ServiceCloud.shared().chatUI.showChat(with: config, showPrechat: true)
      }
      guard let onClick = self.onClick else { return }
   
      let params: [String : Any] = ["value1":"react demo","value2":1]
      onClick(params)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
 
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
 
  private func setupView() {
    // in here you can configure your view
    self.backgroundColor = self.status ? .green : .red
    self.isUserInteractionEnabled = true
  }

}

@objc (RCTMyCustomViewManager)
class RCTMyCustomViewManager: RCTViewManager {
 
  override static func requiresMainQueueSetup() -> Bool {
    return true
  }
 
  override func view() -> UIView! {
    return MyCustomView()
  }
 
}
