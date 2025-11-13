module LineROM(
    input [13:0] iAddr,
    output reg signed [15:0] oData
);

always @(*) begin
    case(iAddr)
      10'd0: oData = -16'd115;
10'd1: oData = 16'd26;
10'd2: oData = 16'd238;
10'd3: oData = -16'd96;
10'd4: oData = 16'd41;
10'd5: oData = 16'd162;

10'd6: oData = -16'd115;
10'd7: oData = 16'd26;
10'd8: oData = 16'd238;
10'd9: oData = -16'd71;
10'd10: oData = -16'd10;
10'd11: oData = 16'd129;

10'd12: oData = -16'd115;
10'd13: oData = 16'd26;
10'd14: oData = 16'd238;
10'd15: oData = -16'd58;
10'd16: oData = 16'd39;
10'd17: oData = 16'd148;

10'd18: oData = -16'd115;
10'd19: oData = 16'd26;
10'd20: oData = 16'd238;
10'd21: oData = -16'd46;
10'd22: oData = -16'd5;
10'd23: oData = 16'd162;

10'd24: oData = -16'd96;
10'd25: oData = 16'd41;
10'd26: oData = 16'd162;
10'd27: oData = -16'd71;
10'd28: oData = -16'd10;
10'd29: oData = 16'd129;

10'd30: oData = -16'd96;
10'd31: oData = 16'd41;
10'd32: oData = 16'd162;
10'd33: oData = -16'd58;
10'd34: oData = 16'd39;
10'd35: oData = 16'd148;

10'd36: oData = -16'd76;
10'd37: oData = -16'd26;
10'd38: oData = -16'd151;
10'd39: oData = -16'd70;
10'd40: oData = -16'd25;
10'd41: oData = -16'd8;

10'd42: oData = -16'd76;
10'd43: oData = -16'd26;
10'd44: oData = -16'd151;
10'd45: oData = -16'd69;
10'd46: oData = 16'd5;
10'd47: oData = 16'd24;

10'd48: oData = -16'd76;
10'd49: oData = -16'd26;
10'd50: oData = -16'd151;
10'd51: oData = -16'd68;
10'd52: oData = 16'd68;
10'd53: oData = -16'd109;

10'd54: oData = -16'd76;
10'd55: oData = -16'd26;
10'd56: oData = -16'd151;
10'd57: oData = -16'd60;
10'd58: oData = 16'd52;
10'd59: oData = 16'd40;

10'd60: oData = -16'd76;
10'd61: oData = -16'd26;
10'd62: oData = -16'd151;
10'd63: oData = -16'd56;
10'd64: oData = -16'd35;
10'd65: oData = -16'd122;

10'd66: oData = -16'd76;
10'd67: oData = -16'd26;
10'd68: oData = -16'd151;
10'd69: oData = -16'd48;
10'd70: oData = 16'd41;
10'd71: oData = -16'd157;

10'd72: oData = -16'd76;
10'd73: oData = -16'd26;
10'd74: oData = -16'd151;
10'd75: oData = 16'd3;
10'd76: oData = 16'd0;
10'd77: oData = -16'd159;

10'd78: oData = -16'd71;
10'd79: oData = -16'd10;
10'd80: oData = 16'd129;
10'd81: oData = -16'd69;
10'd82: oData = 16'd5;
10'd83: oData = 16'd24;

10'd84: oData = -16'd71;
10'd85: oData = -16'd10;
10'd86: oData = 16'd129;
10'd87: oData = -16'd58;
10'd88: oData = 16'd39;
10'd89: oData = 16'd148;

10'd90: oData = -16'd71;
10'd91: oData = -16'd10;
10'd92: oData = 16'd129;
10'd93: oData = -16'd52;
10'd94: oData = -16'd51;
10'd95: oData = 16'd52;

10'd96: oData = -16'd71;
10'd97: oData = -16'd10;
10'd98: oData = 16'd129;
10'd99: oData = -16'd46;
10'd100: oData = -16'd5;
10'd101: oData = 16'd162;

10'd102: oData = -16'd71;
10'd103: oData = -16'd10;
10'd104: oData = 16'd129;
10'd105: oData = -16'd45;
10'd106: oData = -16'd40;
10'd107: oData = 16'd122;

10'd108: oData = -16'd70;
10'd109: oData = -16'd25;
10'd110: oData = -16'd8;
10'd111: oData = -16'd69;
10'd112: oData = 16'd5;
10'd113: oData = 16'd24;

10'd114: oData = -16'd70;
10'd115: oData = -16'd25;
10'd116: oData = -16'd8;
10'd117: oData = -16'd56;
10'd118: oData = -16'd35;
10'd119: oData = -16'd122;

10'd120: oData = -16'd70;
10'd121: oData = -16'd25;
10'd122: oData = -16'd8;
10'd123: oData = -16'd35;
10'd124: oData = -16'd29;
10'd125: oData = 16'd20;

10'd126: oData = -16'd70;
10'd127: oData = -16'd25;
10'd128: oData = -16'd8;
10'd129: oData = -16'd21;
10'd130: oData = -16'd57;
10'd131: oData = -16'd45;

10'd132: oData = -16'd70;
10'd133: oData = -16'd25;
10'd134: oData = -16'd8;
10'd135: oData = -16'd8;
10'd136: oData = -16'd49;
10'd137: oData = -16'd49;

10'd138: oData = -16'd69;
10'd139: oData = 16'd5;
10'd140: oData = 16'd24;
10'd141: oData = -16'd60;
10'd142: oData = 16'd52;
10'd143: oData = 16'd40;

10'd144: oData = -16'd69;
10'd145: oData = 16'd5;
10'd146: oData = 16'd24;
10'd147: oData = -16'd58;
10'd148: oData = 16'd39;
10'd149: oData = 16'd148;

10'd150: oData = -16'd69;
10'd151: oData = 16'd5;
10'd152: oData = 16'd24;
10'd153: oData = -16'd52;
10'd154: oData = -16'd51;
10'd155: oData = 16'd52;

10'd156: oData = -16'd69;
10'd157: oData = 16'd5;
10'd158: oData = 16'd24;
10'd159: oData = -16'd35;
10'd160: oData = -16'd29;
10'd161: oData = 16'd20;

10'd162: oData = -16'd68;
10'd163: oData = 16'd68;
10'd164: oData = -16'd109;
10'd165: oData = -16'd60;
10'd166: oData = 16'd52;
10'd167: oData = 16'd40;

10'd168: oData = -16'd68;
10'd169: oData = 16'd68;
10'd170: oData = -16'd109;
10'd171: oData = -16'd48;
10'd172: oData = 16'd41;
10'd173: oData = -16'd157;

10'd174: oData = -16'd68;
10'd175: oData = 16'd68;
10'd176: oData = -16'd109;
10'd177: oData = -16'd13;
10'd178: oData = 16'd61;
10'd179: oData = -16'd157;

10'd180: oData = -16'd68;
10'd181: oData = 16'd68;
10'd182: oData = -16'd109;
10'd183: oData = 16'd4;
10'd184: oData = 16'd70;
10'd185: oData = 16'd149;

10'd186: oData = -16'd68;
10'd187: oData = 16'd68;
10'd188: oData = -16'd109;
10'd189: oData = 16'd4;
10'd190: oData = 16'd101;
10'd191: oData = -16'd123;

10'd192: oData = -16'd60;
10'd193: oData = 16'd52;
10'd194: oData = 16'd40;
10'd195: oData = -16'd58;
10'd196: oData = 16'd39;
10'd197: oData = 16'd148;

10'd198: oData = -16'd60;
10'd199: oData = 16'd52;
10'd200: oData = 16'd40;
10'd201: oData = 16'd4;
10'd202: oData = 16'd70;
10'd203: oData = 16'd149;

10'd204: oData = -16'd58;
10'd205: oData = 16'd39;
10'd206: oData = 16'd148;
10'd207: oData = -16'd46;
10'd208: oData = -16'd5;
10'd209: oData = 16'd162;

10'd210: oData = -16'd58;
10'd211: oData = 16'd39;
10'd212: oData = 16'd148;
10'd213: oData = 16'd4;
10'd214: oData = 16'd70;
10'd215: oData = 16'd149;

10'd216: oData = -16'd58;
10'd217: oData = 16'd39;
10'd218: oData = 16'd148;
10'd219: oData = 16'd41;
10'd220: oData = -16'd7;
10'd221: oData = 16'd169;

10'd222: oData = -16'd56;
10'd223: oData = -16'd35;
10'd224: oData = -16'd122;
10'd225: oData = -16'd21;
10'd226: oData = -16'd57;
10'd227: oData = -16'd45;

10'd228: oData = -16'd56;
10'd229: oData = -16'd35;
10'd230: oData = -16'd122;
10'd231: oData = 16'd3;
10'd232: oData = -16'd58;
10'd233: oData = -16'd109;

10'd234: oData = -16'd56;
10'd235: oData = -16'd35;
10'd236: oData = -16'd122;
10'd237: oData = 16'd3;
10'd238: oData = 16'd0;
10'd239: oData = -16'd159;

10'd240: oData = -16'd52;
10'd241: oData = -16'd51;
10'd242: oData = 16'd52;
10'd243: oData = -16'd45;
10'd244: oData = -16'd40;
10'd245: oData = 16'd122;

10'd246: oData = -16'd52;
10'd247: oData = -16'd51;
10'd248: oData = 16'd52;
10'd249: oData = -16'd35;
10'd250: oData = -16'd29;
10'd251: oData = 16'd20;

10'd252: oData = -16'd52;
10'd253: oData = -16'd51;
10'd254: oData = 16'd52;
10'd255: oData = 16'd2;
10'd256: oData = -16'd73;
10'd257: oData = 16'd49;

10'd258: oData = -16'd52;
10'd259: oData = -16'd51;
10'd260: oData = 16'd52;
10'd261: oData = 16'd15;
10'd262: oData = -16'd56;
10'd263: oData = 16'd126;

10'd264: oData = -16'd52;
10'd265: oData = -16'd51;
10'd266: oData = 16'd52;
10'd267: oData = 16'd20;
10'd268: oData = -16'd41;
10'd269: oData = 16'd17;

10'd270: oData = -16'd48;
10'd271: oData = 16'd41;
10'd272: oData = -16'd157;
10'd273: oData = -16'd13;
10'd274: oData = 16'd61;
10'd275: oData = -16'd157;

10'd276: oData = -16'd48;
10'd277: oData = 16'd41;
10'd278: oData = -16'd157;
10'd279: oData = 16'd3;
10'd280: oData = 16'd0;
10'd281: oData = -16'd159;

10'd282: oData = -16'd46;
10'd283: oData = -16'd5;
10'd284: oData = 16'd162;
10'd285: oData = -16'd45;
10'd286: oData = -16'd40;
10'd287: oData = 16'd122;

10'd288: oData = -16'd46;
10'd289: oData = -16'd5;
10'd290: oData = 16'd162;
10'd291: oData = 16'd15;
10'd292: oData = -16'd56;
10'd293: oData = 16'd126;

10'd294: oData = -16'd46;
10'd295: oData = -16'd5;
10'd296: oData = 16'd162;
10'd297: oData = 16'd41;
10'd298: oData = -16'd7;
10'd299: oData = 16'd169;

10'd300: oData = -16'd45;
10'd301: oData = -16'd40;
10'd302: oData = 16'd122;
10'd303: oData = 16'd15;
10'd304: oData = -16'd56;
10'd305: oData = 16'd126;

10'd306: oData = -16'd35;
10'd307: oData = -16'd29;
10'd308: oData = 16'd20;
10'd309: oData = -16'd8;
10'd310: oData = -16'd49;
10'd311: oData = -16'd49;

10'd312: oData = -16'd35;
10'd313: oData = -16'd29;
10'd314: oData = 16'd20;
10'd315: oData = 16'd20;
10'd316: oData = -16'd41;
10'd317: oData = 16'd17;

10'd318: oData = -16'd22;
10'd319: oData = 16'd196;
10'd320: oData = 16'd141;
10'd321: oData = -16'd19;
10'd322: oData = 16'd109;
10'd323: oData = 16'd13;

10'd324: oData = -16'd22;
10'd325: oData = 16'd196;
10'd326: oData = 16'd141;
10'd327: oData = 16'd4;
10'd328: oData = 16'd253;
10'd329: oData = 16'd71;

10'd330: oData = -16'd22;
10'd331: oData = 16'd196;
10'd332: oData = 16'd141;
10'd333: oData = 16'd26;
10'd334: oData = 16'd109;
10'd335: oData = 16'd14;

10'd336: oData = -16'd22;
10'd337: oData = 16'd196;
10'd338: oData = 16'd141;
10'd339: oData = 16'd31;
10'd340: oData = 16'd196;
10'd341: oData = 16'd141;

10'd342: oData = -16'd21;
10'd343: oData = -16'd57;
10'd344: oData = -16'd45;
10'd345: oData = -16'd8;
10'd346: oData = -16'd49;
10'd347: oData = -16'd49;

10'd348: oData = -16'd21;
10'd349: oData = -16'd57;
10'd350: oData = -16'd45;
10'd351: oData = 16'd3;
10'd352: oData = -16'd58;
10'd353: oData = -16'd109;

10'd354: oData = -16'd20;
10'd355: oData = 16'd141;
10'd356: oData = -16'd38;
10'd357: oData = -16'd19;
10'd358: oData = 16'd109;
10'd359: oData = 16'd13;

10'd360: oData = -16'd20;
10'd361: oData = 16'd141;
10'd362: oData = -16'd38;
10'd363: oData = -16'd14;
10'd364: oData = 16'd133;
10'd365: oData = -16'd108;

10'd366: oData = -16'd20;
10'd367: oData = 16'd141;
10'd368: oData = -16'd38;
10'd369: oData = 16'd5;
10'd370: oData = 16'd209;
10'd371: oData = -16'd48;

10'd372: oData = -16'd20;
10'd373: oData = 16'd141;
10'd374: oData = -16'd38;
10'd375: oData = 16'd22;
10'd376: oData = 16'd124;
10'd377: oData = -16'd86;

10'd378: oData = -16'd20;
10'd379: oData = 16'd141;
10'd380: oData = -16'd38;
10'd381: oData = 16'd27;
10'd382: oData = 16'd140;
10'd383: oData = -16'd38;

10'd384: oData = -16'd19;
10'd385: oData = 16'd109;
10'd386: oData = 16'd13;
10'd387: oData = 16'd4;
10'd388: oData = 16'd253;
10'd389: oData = 16'd71;

10'd390: oData = -16'd19;
10'd391: oData = 16'd109;
10'd392: oData = 16'd13;
10'd393: oData = 16'd5;
10'd394: oData = 16'd209;
10'd395: oData = -16'd48;

10'd396: oData = -16'd19;
10'd397: oData = 16'd109;
10'd398: oData = 16'd13;
10'd399: oData = 16'd26;
10'd400: oData = 16'd109;
10'd401: oData = 16'd14;

10'd402: oData = -16'd19;
10'd403: oData = 16'd109;
10'd404: oData = 16'd13;
10'd405: oData = 16'd27;
10'd406: oData = 16'd140;
10'd407: oData = -16'd38;

10'd408: oData = -16'd14;
10'd409: oData = 16'd133;
10'd410: oData = -16'd108;
10'd411: oData = -16'd13;
10'd412: oData = 16'd61;
10'd413: oData = -16'd157;

10'd414: oData = -16'd14;
10'd415: oData = 16'd133;
10'd416: oData = -16'd108;
10'd417: oData = -16'd8;
10'd418: oData = 16'd186;
10'd419: oData = -16'd143;

10'd420: oData = -16'd14;
10'd421: oData = 16'd133;
10'd422: oData = -16'd108;
10'd423: oData = 16'd4;
10'd424: oData = 16'd101;
10'd425: oData = -16'd123;

10'd426: oData = -16'd14;
10'd427: oData = 16'd133;
10'd428: oData = -16'd108;
10'd429: oData = 16'd4;
10'd430: oData = 16'd176;
10'd431: oData = -16'd95;

10'd432: oData = -16'd14;
10'd433: oData = 16'd133;
10'd434: oData = -16'd108;
10'd435: oData = 16'd5;
10'd436: oData = 16'd209;
10'd437: oData = -16'd48;

10'd438: oData = -16'd14;
10'd439: oData = 16'd133;
10'd440: oData = -16'd108;
10'd441: oData = 16'd22;
10'd442: oData = 16'd124;
10'd443: oData = -16'd86;

10'd444: oData = -16'd14;
10'd445: oData = 16'd133;
10'd446: oData = -16'd108;
10'd447: oData = 16'd27;
10'd448: oData = 16'd140;
10'd449: oData = -16'd117;

10'd450: oData = -16'd13;
10'd451: oData = 16'd61;
10'd452: oData = -16'd157;
10'd453: oData = -16'd8;
10'd454: oData = 16'd186;
10'd455: oData = -16'd143;

10'd456: oData = -16'd13;
10'd457: oData = 16'd61;
10'd458: oData = -16'd157;
10'd459: oData = 16'd3;
10'd460: oData = 16'd0;
10'd461: oData = -16'd159;

10'd462: oData = -16'd13;
10'd463: oData = 16'd61;
10'd464: oData = -16'd157;
10'd465: oData = 16'd4;
10'd466: oData = 16'd101;
10'd467: oData = -16'd123;

10'd468: oData = -16'd13;
10'd469: oData = 16'd61;
10'd470: oData = -16'd157;
10'd471: oData = 16'd16;
10'd472: oData = 16'd184;
10'd473: oData = -16'd150;

10'd474: oData = -16'd8;
10'd475: oData = 16'd186;
10'd476: oData = -16'd143;
10'd477: oData = 16'd4;
10'd478: oData = 16'd176;
10'd479: oData = -16'd95;

10'd480: oData = -16'd8;
10'd481: oData = 16'd186;
10'd482: oData = -16'd143;
10'd483: oData = 16'd16;
10'd484: oData = 16'd184;
10'd485: oData = -16'd150;

10'd486: oData = -16'd8;
10'd487: oData = -16'd49;
10'd488: oData = -16'd49;
10'd489: oData = 16'd3;
10'd490: oData = -16'd58;
10'd491: oData = -16'd109;

10'd492: oData = -16'd8;
10'd493: oData = -16'd49;
10'd494: oData = -16'd49;
10'd495: oData = 16'd20;
10'd496: oData = -16'd41;
10'd497: oData = 16'd17;

10'd498: oData = 16'd2;
10'd499: oData = -16'd73;
10'd500: oData = 16'd49;
10'd501: oData = 16'd15;
10'd502: oData = -16'd56;
10'd503: oData = 16'd126;

10'd504: oData = 16'd2;
10'd505: oData = -16'd73;
10'd506: oData = 16'd49;
10'd507: oData = 16'd20;
10'd508: oData = -16'd41;
10'd509: oData = 16'd17;

10'd510: oData = 16'd2;
10'd511: oData = -16'd73;
10'd512: oData = 16'd49;
10'd513: oData = 16'd49;
10'd514: oData = -16'd39;
10'd515: oData = 16'd117;

10'd516: oData = 16'd2;
10'd517: oData = -16'd73;
10'd518: oData = 16'd49;
10'd519: oData = 16'd57;
10'd520: oData = -16'd54;
10'd521: oData = 16'd53;

10'd522: oData = 16'd3;
10'd523: oData = -16'd58;
10'd524: oData = -16'd109;
10'd525: oData = 16'd3;
10'd526: oData = 16'd0;
10'd527: oData = -16'd159;

10'd528: oData = 16'd3;
10'd529: oData = -16'd58;
10'd530: oData = -16'd109;
10'd531: oData = 16'd20;
10'd532: oData = -16'd41;
10'd533: oData = 16'd17;

10'd534: oData = 16'd3;
10'd535: oData = -16'd58;
10'd536: oData = -16'd109;
10'd537: oData = 16'd27;
10'd538: oData = -16'd53;
10'd539: oData = -16'd47;

10'd540: oData = 16'd3;
10'd541: oData = -16'd58;
10'd542: oData = -16'd109;
10'd543: oData = 16'd63;
10'd544: oData = -16'd35;
10'd545: oData = -16'd122;

10'd546: oData = 16'd3;
10'd547: oData = 16'd0;
10'd548: oData = -16'd159;
10'd549: oData = 16'd16;
10'd550: oData = 16'd184;
10'd551: oData = -16'd150;

10'd552: oData = 16'd3;
10'd553: oData = 16'd0;
10'd554: oData = -16'd159;
10'd555: oData = 16'd20;
10'd556: oData = 16'd61;
10'd557: oData = -16'd157;

10'd558: oData = 16'd3;
10'd559: oData = 16'd0;
10'd560: oData = -16'd159;
10'd561: oData = 16'd55;
10'd562: oData = 16'd41;
10'd563: oData = -16'd157;

10'd564: oData = 16'd3;
10'd565: oData = 16'd0;
10'd566: oData = -16'd159;
10'd567: oData = 16'd63;
10'd568: oData = -16'd35;
10'd569: oData = -16'd122;

10'd570: oData = 16'd3;
10'd571: oData = 16'd0;
10'd572: oData = -16'd159;
10'd573: oData = 16'd82;
10'd574: oData = -16'd27;
10'd575: oData = -16'd151;

10'd576: oData = 16'd4;
10'd577: oData = 16'd70;
10'd578: oData = 16'd149;
10'd579: oData = 16'd4;
10'd580: oData = 16'd101;
10'd581: oData = -16'd123;

10'd582: oData = 16'd4;
10'd583: oData = 16'd70;
10'd584: oData = 16'd149;
10'd585: oData = 16'd41;
10'd586: oData = -16'd7;
10'd587: oData = 16'd169;

10'd588: oData = 16'd4;
10'd589: oData = 16'd70;
10'd590: oData = 16'd149;
10'd591: oData = 16'd67;
10'd592: oData = 16'd51;
10'd593: oData = 16'd40;

10'd594: oData = 16'd4;
10'd595: oData = 16'd70;
10'd596: oData = 16'd149;
10'd597: oData = 16'd69;
10'd598: oData = 16'd39;
10'd599: oData = 16'd150;

10'd600: oData = 16'd4;
10'd601: oData = 16'd70;
10'd602: oData = 16'd149;
10'd603: oData = 16'd75;
10'd604: oData = 16'd67;
10'd605: oData = -16'd109;

10'd606: oData = 16'd4;
10'd607: oData = 16'd101;
10'd608: oData = -16'd123;
10'd609: oData = 16'd20;
10'd610: oData = 16'd61;
10'd611: oData = -16'd157;

10'd612: oData = 16'd4;
10'd613: oData = 16'd101;
10'd614: oData = -16'd123;
10'd615: oData = 16'd27;
10'd616: oData = 16'd140;
10'd617: oData = -16'd117;

10'd618: oData = 16'd4;
10'd619: oData = 16'd101;
10'd620: oData = -16'd123;
10'd621: oData = 16'd75;
10'd622: oData = 16'd67;
10'd623: oData = -16'd109;

10'd624: oData = 16'd4;
10'd625: oData = 16'd176;
10'd626: oData = -16'd95;
10'd627: oData = 16'd5;
10'd628: oData = 16'd209;
10'd629: oData = -16'd48;

10'd630: oData = 16'd4;
10'd631: oData = 16'd176;
10'd632: oData = -16'd95;
10'd633: oData = 16'd16;
10'd634: oData = 16'd184;
10'd635: oData = -16'd150;

10'd636: oData = 16'd4;
10'd637: oData = 16'd176;
10'd638: oData = -16'd95;
10'd639: oData = 16'd22;
10'd640: oData = 16'd124;
10'd641: oData = -16'd86;

10'd642: oData = 16'd4;
10'd643: oData = 16'd176;
10'd644: oData = -16'd95;
10'd645: oData = 16'd27;
10'd646: oData = 16'd140;
10'd647: oData = -16'd117;

10'd648: oData = 16'd4;
10'd649: oData = 16'd253;
10'd650: oData = 16'd71;
10'd651: oData = 16'd5;
10'd652: oData = 16'd209;
10'd653: oData = -16'd48;

10'd654: oData = 16'd4;
10'd655: oData = 16'd253;
10'd656: oData = 16'd71;
10'd657: oData = 16'd26;
10'd658: oData = 16'd109;
10'd659: oData = 16'd14;

10'd660: oData = 16'd4;
10'd661: oData = 16'd253;
10'd662: oData = 16'd71;
10'd663: oData = 16'd31;
10'd664: oData = 16'd196;
10'd665: oData = 16'd141;

10'd666: oData = 16'd5;
10'd667: oData = 16'd209;
10'd668: oData = -16'd48;
10'd669: oData = 16'd22;
10'd670: oData = 16'd124;
10'd671: oData = -16'd86;

10'd672: oData = 16'd5;
10'd673: oData = 16'd209;
10'd674: oData = -16'd48;
10'd675: oData = 16'd26;
10'd676: oData = 16'd109;
10'd677: oData = 16'd14;

10'd678: oData = 16'd5;
10'd679: oData = 16'd209;
10'd680: oData = -16'd48;
10'd681: oData = 16'd27;
10'd682: oData = 16'd140;
10'd683: oData = -16'd38;

10'd684: oData = 16'd15;
10'd685: oData = -16'd56;
10'd686: oData = 16'd126;
10'd687: oData = 16'd41;
10'd688: oData = -16'd7;
10'd689: oData = 16'd169;

10'd690: oData = 16'd15;
10'd691: oData = -16'd56;
10'd692: oData = 16'd126;
10'd693: oData = 16'd49;
10'd694: oData = -16'd39;
10'd695: oData = 16'd117;

10'd696: oData = 16'd16;
10'd697: oData = 16'd184;
10'd698: oData = -16'd150;
10'd699: oData = 16'd20;
10'd700: oData = 16'd61;
10'd701: oData = -16'd157;

10'd702: oData = 16'd16;
10'd703: oData = 16'd184;
10'd704: oData = -16'd150;
10'd705: oData = 16'd27;
10'd706: oData = 16'd140;
10'd707: oData = -16'd117;

10'd708: oData = 16'd20;
10'd709: oData = -16'd41;
10'd710: oData = 16'd17;
10'd711: oData = 16'd27;
10'd712: oData = -16'd53;
10'd713: oData = -16'd47;

10'd714: oData = 16'd20;
10'd715: oData = -16'd41;
10'd716: oData = 16'd17;
10'd717: oData = 16'd57;
10'd718: oData = -16'd54;
10'd719: oData = 16'd53;

10'd720: oData = 16'd20;
10'd721: oData = -16'd41;
10'd722: oData = 16'd17;
10'd723: oData = 16'd71;
10'd724: oData = 16'd14;
10'd725: oData = 16'd19;

10'd726: oData = 16'd20;
10'd727: oData = -16'd41;
10'd728: oData = 16'd17;
10'd729: oData = 16'd76;
10'd730: oData = -16'd26;
10'd731: oData = -16'd8;

10'd732: oData = 16'd20;
10'd733: oData = -16'd41;
10'd734: oData = 16'd17;
10'd735: oData = 16'd84;
10'd736: oData = -16'd12;
10'd737: oData = 16'd46;

10'd738: oData = 16'd20;
10'd739: oData = 16'd61;
10'd740: oData = -16'd157;
10'd741: oData = 16'd27;
10'd742: oData = 16'd140;
10'd743: oData = -16'd117;

10'd744: oData = 16'd20;
10'd745: oData = 16'd61;
10'd746: oData = -16'd157;
10'd747: oData = 16'd55;
10'd748: oData = 16'd41;
10'd749: oData = -16'd157;

10'd750: oData = 16'd20;
10'd751: oData = 16'd61;
10'd752: oData = -16'd157;
10'd753: oData = 16'd75;
10'd754: oData = 16'd67;
10'd755: oData = -16'd109;

10'd756: oData = 16'd22;
10'd757: oData = 16'd124;
10'd758: oData = -16'd86;
10'd759: oData = 16'd27;
10'd760: oData = 16'd140;
10'd761: oData = -16'd117;

10'd762: oData = 16'd22;
10'd763: oData = 16'd124;
10'd764: oData = -16'd86;
10'd765: oData = 16'd27;
10'd766: oData = 16'd140;
10'd767: oData = -16'd38;

10'd768: oData = 16'd26;
10'd769: oData = 16'd109;
10'd770: oData = 16'd14;
10'd771: oData = 16'd27;
10'd772: oData = 16'd140;
10'd773: oData = -16'd38;

10'd774: oData = 16'd26;
10'd775: oData = 16'd109;
10'd776: oData = 16'd14;
10'd777: oData = 16'd31;
10'd778: oData = 16'd196;
10'd779: oData = 16'd141;

10'd780: oData = 16'd27;
10'd781: oData = -16'd53;
10'd782: oData = -16'd47;
10'd783: oData = 16'd63;
10'd784: oData = -16'd35;
10'd785: oData = -16'd122;

10'd786: oData = 16'd27;
10'd787: oData = -16'd53;
10'd788: oData = -16'd47;
10'd789: oData = 16'd76;
10'd790: oData = -16'd26;
10'd791: oData = -16'd8;

10'd792: oData = 16'd41;
10'd793: oData = -16'd7;
10'd794: oData = 16'd169;
10'd795: oData = 16'd49;
10'd796: oData = -16'd39;
10'd797: oData = 16'd117;

10'd798: oData = 16'd41;
10'd799: oData = -16'd7;
10'd800: oData = 16'd169;
10'd801: oData = 16'd69;
10'd802: oData = 16'd39;
10'd803: oData = 16'd150;

10'd804: oData = 16'd41;
10'd805: oData = -16'd7;
10'd806: oData = 16'd169;
10'd807: oData = 16'd70;
10'd808: oData = 16'd26;
10'd809: oData = 16'd259;

10'd810: oData = 16'd41;
10'd811: oData = -16'd7;
10'd812: oData = 16'd169;
10'd813: oData = 16'd78;
10'd814: oData = -16'd9;
10'd815: oData = 16'd138;

10'd816: oData = 16'd49;
10'd817: oData = -16'd39;
10'd818: oData = 16'd117;
10'd819: oData = 16'd57;
10'd820: oData = -16'd54;
10'd821: oData = 16'd53;

10'd822: oData = 16'd49;
10'd823: oData = -16'd39;
10'd824: oData = 16'd117;
10'd825: oData = 16'd78;
10'd826: oData = -16'd9;
10'd827: oData = 16'd138;

10'd828: oData = 16'd55;
10'd829: oData = 16'd41;
10'd830: oData = -16'd157;
10'd831: oData = 16'd75;
10'd832: oData = 16'd67;
10'd833: oData = -16'd109;

10'd834: oData = 16'd55;
10'd835: oData = 16'd41;
10'd836: oData = -16'd157;
10'd837: oData = 16'd82;
10'd838: oData = -16'd27;
10'd839: oData = -16'd151;

10'd840: oData = 16'd57;
10'd841: oData = -16'd54;
10'd842: oData = 16'd53;
10'd843: oData = 16'd78;
10'd844: oData = -16'd9;
10'd845: oData = 16'd138;

10'd846: oData = 16'd57;
10'd847: oData = -16'd54;
10'd848: oData = 16'd53;
10'd849: oData = 16'd84;
10'd850: oData = -16'd12;
10'd851: oData = 16'd46;

10'd852: oData = 16'd63;
10'd853: oData = -16'd35;
10'd854: oData = -16'd122;
10'd855: oData = 16'd76;
10'd856: oData = -16'd26;
10'd857: oData = -16'd8;

10'd858: oData = 16'd63;
10'd859: oData = -16'd35;
10'd860: oData = -16'd122;
10'd861: oData = 16'd82;
10'd862: oData = -16'd27;
10'd863: oData = -16'd151;

10'd864: oData = 16'd67;
10'd865: oData = 16'd51;
10'd866: oData = 16'd40;
10'd867: oData = 16'd69;
10'd868: oData = 16'd39;
10'd869: oData = 16'd150;

10'd870: oData = 16'd67;
10'd871: oData = 16'd51;
10'd872: oData = 16'd40;
10'd873: oData = 16'd71;
10'd874: oData = 16'd14;
10'd875: oData = 16'd19;

10'd876: oData = 16'd67;
10'd877: oData = 16'd51;
10'd878: oData = 16'd40;
10'd879: oData = 16'd75;
10'd880: oData = 16'd67;
10'd881: oData = -16'd109;

10'd882: oData = 16'd67;
10'd883: oData = 16'd51;
10'd884: oData = 16'd40;
10'd885: oData = 16'd82;
10'd886: oData = -16'd27;
10'd887: oData = -16'd151;

10'd888: oData = 16'd67;
10'd889: oData = 16'd51;
10'd890: oData = 16'd40;
10'd891: oData = 16'd84;
10'd892: oData = -16'd12;
10'd893: oData = 16'd46;

10'd894: oData = 16'd69;
10'd895: oData = 16'd39;
10'd896: oData = 16'd150;
10'd897: oData = 16'd70;
10'd898: oData = 16'd26;
10'd899: oData = 16'd259;

10'd900: oData = 16'd69;
10'd901: oData = 16'd39;
10'd902: oData = 16'd150;
10'd903: oData = 16'd78;
10'd904: oData = -16'd9;
10'd905: oData = 16'd138;

10'd906: oData = 16'd69;
10'd907: oData = 16'd39;
10'd908: oData = 16'd150;
10'd909: oData = 16'd84;
10'd910: oData = -16'd12;
10'd911: oData = 16'd46;

10'd912: oData = 16'd70;
10'd913: oData = 16'd26;
10'd914: oData = 16'd259;
10'd915: oData = 16'd78;
10'd916: oData = -16'd9;
10'd917: oData = 16'd138;

10'd918: oData = 16'd71;
10'd919: oData = 16'd14;
10'd920: oData = 16'd19;
10'd921: oData = 16'd76;
10'd922: oData = -16'd26;
10'd923: oData = -16'd8;

10'd924: oData = 16'd71;
10'd925: oData = 16'd14;
10'd926: oData = 16'd19;
10'd927: oData = 16'd82;
10'd928: oData = -16'd27;
10'd929: oData = -16'd151;

10'd930: oData = 16'd71;
10'd931: oData = 16'd14;
10'd932: oData = 16'd19;
10'd933: oData = 16'd84;
10'd934: oData = -16'd12;
10'd935: oData = 16'd46;

10'd936: oData = 16'd75;
10'd937: oData = 16'd67;
10'd938: oData = -16'd109;
10'd939: oData = 16'd82;
10'd940: oData = -16'd27;
10'd941: oData = -16'd151;

10'd942: oData = 16'd76;
10'd943: oData = -16'd26;
10'd944: oData = -16'd8;
10'd945: oData = 16'd82;
10'd946: oData = -16'd27;
10'd947: oData = -16'd151;

10'd948: oData = 16'd78;
10'd949: oData = -16'd9;
10'd950: oData = 16'd138;
10'd951: oData = 16'd84;
10'd952: oData = -16'd12;
10'd953: oData = 16'd46;

default: oData = 0;
    endcase
end

endmodule