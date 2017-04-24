//
//  NSData+AES.h
//  Cryptoassignment
//
//  Created by Athitha Anantharamu on 11/11/16.
//  Copyright © 2016 Athitha Anantharamu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES)

- (NSData *) EncryptAES: (NSString *) key;
- (NSData *) DecryptAES: (NSString *) key;


@end
