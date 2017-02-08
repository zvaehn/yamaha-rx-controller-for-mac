//
//  CommunicationController.m
//  Yamaha RX-Controller for MAC
//
//  Created by Sven Schiffer on 08/02/2017.
//  Copyright © 2017 Sven Schiffer. All rights reserved.
//

#import "CommunicationController.h"

@implementation CommunicationController

-(id) init
{
    if(self = [super init]) {
       self.ip = @"http://192.168.178.26";
    }
    
    return self;
}

-(BOOL) connect {
    return true;
}


-(BOOL) sendCommand:(NSString*)identifiedByString {
    NSString *url = [self.ip stringByAppendingString: @"/YamahaRemoteControl/ctrl"];
    NSString *post = identifiedByString;
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding];
    NSString *postLength = [NSString stringWithFormat:@"%ld", (unsigned long)[postData length]];
    
    NSMutableURLRequest *request = [NSMutableURLRequest new];
    [request setURL:[NSURL URLWithString: url]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:self.ip forHTTPHeaderField:@"Host"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"text/xml; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setValue:@"Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0" forHTTPHeaderField:@"User-Agent"];
    [request setValue:@"keep-alive" forHTTPHeaderField:@"Connection"];
    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"gzip, deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"de-de,de;q=0.8,en-us;q=0.5,en;q=0.3" forHTTPHeaderField:@"Accept-Language"];
    [request setValue:@"no-cache" forHTTPHeaderField:@"Pragma"];
    [request setValue:@"no-cache" forHTTPHeaderField:@"ache-Control:"];
    [request setHTTPBody:postData];
    
    NSURLConnection *theConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(!theConnection) {
        return false;
    }
    else {
        self.response = [NSMutableData data];
    }
    
    return true;
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.response appendData:data];
    NSLog(@"connection received data");
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSHTTPURLResponse *ne = (NSHTTPURLResponse *)response;
    if([ne statusCode] == 200) {
        self.isConnected = YES;
        NSLog(@"connection state is 200 - all okay");
    } else {
        NSLog(@"connection state is %ld", (long)[ne statusCode]);
    }
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.isConnected = NO;
    NSLog(@"Conn Err: %@", [error localizedDescription]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *xml = [[NSString alloc] initWithBytes: [self.response mutableBytes] length:[self.response length] encoding:NSUTF8StringEncoding];
    NSLog(@"RESPONSE: %@", xml);
    

    
}



@end
