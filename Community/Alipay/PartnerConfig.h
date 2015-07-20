//
//  PartnerConfig.h
//  Community
//
//  Created by SYZ on 13-12-20.
//  Copyright (c) 2013年 Hua Men. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088211273555829"

//收款支付宝账号
#define SellerID  @"taoW@huamen365.com"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @""

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOg4c5pqBUftF0pJJdPGz3rt8Ch9K/okiG4rEHi7sLItTJHiux0RFhpofBCzcDVAEhwymr/+UAduTkBkgicAn+JnqCQYe+QyDl6atJAXweoaeed1M2RYNh/AR/dAij8aVqRF860gcnY4ZGy29KQbluhS6P3iCQmOrr+Ayn/qbg1TAgMBAAECgYEApJ/AdGtMqxzNMgCBLIz4cXFUm5+BGafkgBVPbAfCz82FRraxZ33BaZ9AtKZAmb9+FzdYtVsYaOwt1UBrdDLhJEn69NvHgsgAoI7QwjR4ql2qlKSrRtx/jNE4iPJLBHXMpC83JoB7SUJVuQuuMsFLbRvFRuQ6NM9khMYwa5cNdKECQQD6oi9/DLFlHGcEUa6GnRLhvM3aWHO6le9bLUxfGmcktG4Dldmv4Nv1Wvb5HpV0/evgspMfTDOFXLsCUGyennsFAkEA7TFWZl1U4Lf/ZJFK74cD7cu+hAs2C1+8SBHF8+gw/5yllh+6fe/+B7WqXc9dlJm+ifWD5owe9aGEP2mZ8bnGdwJAN781U0wOdQ/xNfu5FwX++ijVnLhJ3XmWCLC1qP2lbXuYcMG27rDUG+nEvzp3QdNs0MjHgpGfcA1lJymeT1WuxQJAPwZrFMwb75I0lH5e0QKpMph+yQtJkwAfQW8nkEXULzdqcFeB8FDCyT2mRUMCdKfdjz7ji3EUEOSYBVmEBEz+xQJALm3gmkbPi60BQc7HlMO+IKVmXJp1KTPy/YNxf76vakz7IAiW8yzklZBPSacKV2GLsu0Li5jltJYcrH6+KNGd4Q=="

//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#define NOTIFY_URL     @"http://115.29.192.170:8080/duoyi/pai/a_not"

#define URLScheme      @"Community.WuTao"

#endif
