//
//  Config.m
//  mobil-payment
//
//  Created by Torben Toepper on 27.08.11.
//  Copyright 2011 Torben Toepper. All rights reserved.
//

#import "Config.h"

@implementation Config

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(NSString *)webUrl {
   return @"http://localhost:8080/"; 
}

+(NSString *)webUrlTEMP {
    NSLog(@"%@", MAIN_HOSTNAME);
    return MAIN_HOSTNAME;
    return @"http://payment.dev/";
}

+(NSURL *)transactionsUrlWith:(NSString *)hardwareId {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@transactions.json?hardware_id=%@", [Config webUrlTEMP], hardwareId]];
}

+(NSURL *)transactionsUrlWith:(NSString *)hardwareId andIds:(NSArray *)transactionIds {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@transactions.json?hardware_id=%@&ids=%@", [Config webUrlTEMP], hardwareId, [transactionIds componentsJoinedByString:@","]]];
}

+(NSURL *)transactionsUrl:(NSNumber *)customerId {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Config webUrlTEMP], [NSString stringWithFormat:@"customers/%@/transactions.json", customerId]]];
}

+(NSURL *)transactionUrl:(NSString *)customerId transaction:(NSString *)transactionId asJSON:(BOOL)asJSON {
    return [NSURL URLWithString:[Config transactionUrlAsString:customerId transaction:transactionId asJSON:asJSON]];
}

+(NSString *)transactionUrlAsString:(NSString *)customerId transaction:(NSString *)transactionId asJSON:(BOOL)asJSON {
    NSString *json = asJSON ? @".json" : @".png";

    return [NSString stringWithFormat:@"%@%@", [Config webUrlTEMP], [NSString stringWithFormat:@"customers/%@/transactions/%@%@", customerId, transactionId, json]];
}

+(NSURL *)openTransactionsUrl:(NSNumber *)customer_id {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@customers/%@/transactions.json?state=open", [Config webUrlTEMP], customer_id]];
}

+(NSURL *)transactionConfirmationUrl:(NSString *)customerId transaction:(NSString *)transactionId asJSON:(BOOL)asJSON {
    NSString *json = asJSON ? @".json" : @".png";
    
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Config webUrlTEMP], [NSString stringWithFormat:@"customers/%@/transactions/%@/confirm%@", customerId, transactionId, json]]];
}

+(NSURL *)customerUrl:(NSNumber *)customer_id {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Config webUrlTEMP], [NSString stringWithFormat:@"customers/%@.json", customer_id]]];
}


+(NSURL *)newCustomerUrl {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Config webUrlTEMP], @"customers.json"]];
}

+(NSURL *)updateCustomerUrl:token {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", [Config webUrlTEMP], [NSString stringWithFormat:@"customers/%@.json", token]]];
}

+(int)qrCodeCustomerPosition {
    return 4;
}

+(int)qrCodeTransactionPosition {
    return 6;
}

@end
