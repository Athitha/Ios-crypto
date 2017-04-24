//
//  ViewController.h
//  Cryptoassignment
//
//  Created by Athitha Anantharamu on 11/11/16.
//  Copyright © 2016 Athitha Anantharamu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *descript;
- (IBAction)Encryption:(id)sender;
- (IBAction)Decryption:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *identity;

@end

