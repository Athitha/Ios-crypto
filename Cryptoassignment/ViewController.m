//
//  ViewController.m
//  Cryptoassignment
//
//  Created by Athitha Anantharamu on 11/11/16.
//  Copyright © 2016 Athitha Anantharamu. All rights reserved.
//

#import "ViewController.h"
#import "NSData+AES.h"

@interface ViewController ()


@end

@implementation ViewController

NSData *encryptedData1;
NSData *encryptedID;
NSData *encryptedDesc;
NSString *key = @"nv93h50sk1zh508v";


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _descript.returnKeyType = UIReturnKeyDone;
    [_descript setDelegate:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
-(NSString *)Base64Encode:(NSData *)data{
    //Point to start of the data and set buffer sizes
    int inLength = [data length];
    int outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
    const char *inputBuffer = [data bytes];
    char *outputBuffer = malloc(outLength);
    outputBuffer[outLength] = 0;
    
    //64 digit code
    static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    //start the count
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp;
    
    //Pad the last to bytes, the outbuffer must always be a multiple of 4
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    while (inpos < inLength){
        switch (cycle) {
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos]&0xFC)>>2];
                cycle = 1;
                break;
            case 1:
                temp = (inputBuffer[inpos++]&0x03)<<4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0)>> 4];
                temp = (inputBuffer[inpos++]&0x0F)<<2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0)>>6];
                cycle = 4;
                break;
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++]&0x3f];
                cycle = 0;
                break;
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer);
    return pictemp;
}


- (IBAction)Encryption:(id)sender {
    NSString *inputName= _name.text;
    NSString *inputID= _identity.text;
    NSString *inputDesc= _descript.text;
    NSData *data = [inputName dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataID = [inputID  dataUsingEncoding:NSUTF8StringEncoding];
    NSData *dataDesc = [inputDesc dataUsingEncoding:NSUTF8StringEncoding];
    encryptedData1 = [data EncryptAES:key];
    encryptedID = [dataID EncryptAES:key];
    encryptedDesc= [dataDesc EncryptAES:key];
    NSString *encryptedBase64 = [self Base64Encode:encryptedData1];
    NSString *Base64ID = [self Base64Encode:encryptedID];
    NSString *Base64Desc = [self Base64Encode:encryptedDesc];
    _name.text=encryptedBase64;
    _identity.text=Base64ID;
    _descript.text=Base64Desc;
}

- (IBAction)Decryption:(id)sender {
    NSString *decryptedString = [[NSString alloc] initWithData:[encryptedData1 DecryptAES:key] encoding:NSUTF8StringEncoding];
    NSString *decryptedID = [[NSString alloc] initWithData:[encryptedID DecryptAES:key] encoding:NSUTF8StringEncoding];
    NSString *decryptedDesc = [[NSString alloc] initWithData:[encryptedDesc DecryptAES:key] encoding:NSUTF8StringEncoding];
    
    
    _name.text=decryptedString;
    _identity.text=decryptedID;
   _descript.text=decryptedDesc;
}
@end
