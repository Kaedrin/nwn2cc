#include "npc_include"

void NpcSpeak (object oNpc, int nSpeak);

void NpcSpeak (object oNpc, int nSpeak)
{
int nRand = Random (9);
int nOneliner = Random (10);
int nOneliner4 = Random (4);
int nCurrent = GetTimeActivity(oNpc);
{switch (nSpeak)
    {
    default:
    break;
    case 1:
        {switch (nCurrent)
            {
            default:
            break;
    /*      case 1:
			break;
            case 2:
			break;
            case 3:
			break;
            case 4:
			break;
            case 5:
			break;
            case 6:
			break;
    */        
            case 7: //agreeable conversation NpcAgree
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "Yes.. thats what I heard too.");
                        break;
                        case 1:
                        SpeakString ( "I know...amazing isn't it?");
                        break;
                        case 2:
                        SpeakString ( "It is good to see you!");
                        break;              
                        case 3:
                        SpeakString ( "heh.. now that's funny");
                        break;                    
                        case 4:
                        SpeakString ( "Can you believe it");
                        break;  
                        case 5:
                        SpeakString ( "Did you hear about Quinn?");
                        break;  
                        case 6:
                        SpeakString ( "Supposedly the King has ordered the walls repaired");
                        break; 
                        case 7:
                        SpeakString ( "The new commander is due to arrive soon");
                        break;   
                        case 8:
                        SpeakString ( "How is your family doing?");
                        break;     
                        case 9:
                        SpeakString ( "very well");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;
            case 8: // Angry conversation NpcAngry
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "you have got to be kidding me");
                        break;
                        case 1:
                        SpeakString ( "this is all your fault");
                        break;
                        case 2:
                        SpeakString ( "Let me introduce my boot to your butt");
                        break;              
                        case 3:
                        SpeakString ( "maybe if you could have kept your mouth shut");
                        break;                    
                        case 4:
                        SpeakString ( "yeah no surprise there");
                        break;  
                        case 5:
                        SpeakString ( "I never should have listend to you");
                        break;  
                        case 6:
                        SpeakString ( "after all I have done for you now you want what?");
                        break; 
                        case 7:
                        SpeakString ( "I cant beleive what I am hearing");
                        break;   
                        case 8:
                        SpeakString ( "maybe what you need is a solid thrashing");
                        break;     
                        case 9:
                        SpeakString ( "you think you can stop me?");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 9: //Sad conversation NpcSad
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "please... don't");
                        break;
                        case 1:
                        SpeakString ( "I'm begging you");
                        break;
                        case 2:
                        SpeakString ( "say it isn't so");
                        break;              
                        case 3:
                        SpeakString ( "I told you I was sorry already");
                        break;                    
                        case 4:
                        SpeakString ( "there has to be something we can do");
                        break;  
                        case 5:
                        SpeakString ( "I can't beleive this has happened");
                        break;  
                        case 6:
                        SpeakString ( "I'm so sorry");
                        break; 
                        case 7:
                        SpeakString ( "How can I make it up to you");
                        break;   
                        case 8:
                        SpeakString ( "what are we going to do?");
                        break;     
                        case 9:
                        SpeakString ( "I can't help it I just miss her");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 10: //Cooking one liners NpcCook
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "OUCH!");
                        break;
                        case 1:
                        SpeakString ( "you would think I could get something better than turnips once in a while");
                        break;
                        case 2:
                        SpeakString ( "mmmm.. this smells good!");
                        break;                    
                        case 3:
                        SpeakString ( "red meat isn't bad for you... now if it's green...");
                        break;                    
                        case 4:
                        SpeakString ( "OK!!! That's not my hair, who put that in the soup?");
                        break;  
                        case 5:
                        SpeakString ( "Do we have rats or is that a caper?");
                        break;  
                        case 6:
                        SpeakString ( "Surprise! There's tuna in it!");
                        break; 
                        case 7:
                        SpeakString ( "hmmm.. the other OTHER white meat");
                        break;   
                        case 8:
                        SpeakString ( "Hey! Ya you, does this smell like it's turned?");
                        break;     
                        case 9:
                        SpeakString ( "Where did I put that knife?");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 11: //dancing female one liners NpcDanceFemale
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "I've got your stimulus package right here!");
                        break;
                        case 1:
                        SpeakString ( "Do you want to dance?");
                        break;
                        case 2:
                        SpeakString ( "Close your mouth you'll catch flies.");
                        break;                    
                        case 3:
                        SpeakString ( "Dancing is thirsty work, buy a girl a drink?");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	  
            case 12: //dancing male one liners NpcDanceMale
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "I've got your stimulus package right here!");
                        break;
                        case 1:
                        SpeakString ( "Do you want to dance?");
                        break;
                        case 2:
                        SpeakString ( "Oh sorry, did I step on you?");
                        break;                    
                        case 3:
                        SpeakString ( "I have two left feet.");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
    /*        
            case 13: //drumming one liners NpcDrum
			break;
            case 14: //flute one liners NpcFlute
			break;
    */
            case 15: case 30: //forging one liners NpcForge
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "This forge isn't hot enough I need more coal");
                        break;
                        case 1:
                        SpeakString ( "Where did I put those tongs?");
                        break;
                        case 2:
                        SpeakString ( "OUCH!");
                        break;                    
                        case 3:
                        SpeakString ( "Jeez another clinker blocking the tuyere!");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;
    /*
            case 16: //guitar one liners NpcGuitar
			break;
    */                
            case 17: //woodsman one liners NpcWoodsman
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "All day bucking logs");
                        break;
                        case 1:
                        SpeakString ( "I think I need to sharpen this axe.");
                        break;
                        case 2:
                        SpeakString ( "I wonder if I could hook up a skidder with some horses");
                        break;                    
                        case 3:
                        SpeakString ( "This is some thick pitch");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 18: //meditate one liners NpcMeditate
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "oooohhhhhhmmmmmmmmmm");
                        break;
                        case 1:
                        SpeakString ( "give us this day our mumble..mumble...");
                        break;
                        case 2:
                        SpeakString ( "shush!");
                        break;                    
                        case 3:
                        SpeakString ( "oooohhhhhhmmmmmmmmmm");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 19: //post one liners NpcPost
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "Did you hear that?");
                        break;
                        case 1:
                        SpeakString ( "What is that smell?");
                        break;
                        case 2:
                        SpeakString ( "YYAAAWWWWNNNN... man is this boring");
                        break;                    
                        case 3:
                        SpeakString ( "I wonder if I can get someone else to take my next shift?");
                        break;                    
                        case 4:
                        SpeakString ( "So there I was with this fish on the line....");
                        break;  
                        case 5:
                        SpeakString ( "...and you know what he says to me?");
                        break;  
                        case 6:
                        SpeakString ( "So I went to the commander and said LOOK...");
                        break; 
                        case 7:
                        SpeakString ( "...so that's how I ended up on post duty. How about you?");
                        break;   
                        case 8:
                        SpeakString ( "It could be worse I suppose, we could be on polishing detail.");
                        break;     
                        case 9:
                        SpeakString ( "I don't know, I'd rather stand post than walk the circuit.");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 20: //read one liners NpcRead
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "Oh that makes sense now.");
                        break;
                        case 1:
                        SpeakString ( "mumble.. mumble..mumble...");
                        break;
                        case 2:
                        SpeakString ( "shush!");
                        break;                    
                        case 3:
                        SpeakString ( "I guess you cant beleive everything you read after all.");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
    /*        
            case 21: //sit one liners NpcSit
			break;
    */          
            case 22: //sit dinner one liners NpcSitDinner
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "Aroint, thou raunch fed runions.");
                        break;
                        case 1:
                        SpeakString ( "Ha Ha Ha, now that's funny.");
                        break;
                        case 2:
                        SpeakString ( "Is that a hair in my soup?");
                        break;                    
                        case 3:
                        SpeakString ( "Why is it always turnips?");
                        break;                    
                        case 4:
                        SpeakString ( "So there I was with this fish on the line....");
                        break;  
                        case 5:
                        SpeakString ( "If desperate, you can always fart & say Divide that among you!");
                        break;  
                        case 6:
                        SpeakString ( "People dictate their own behavior.");
                        break; 
                        case 7:
                        SpeakString ( "I'm not even supposed to be here today.");
                        break;   
                        case 8:
                        SpeakString ( "...thats what i think they are after also, honesty through paranoia.");
                        break;     
                        case 9:
                        SpeakString ( "I'm a firm believer in the philosophy of a ruling class.");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 23:  //stand chat one liners NpcStandChat
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "And, what is your name?");
                        break;
                        case 1:
                        SpeakString ( "How can a blind man be a lookout?");
                        break;
                        case 2:
                        SpeakString ( "you have got to be kidding me");
                        break;                    
                        case 3:
                        SpeakString ( "heh.. now that's funny");
                        break;                    
                        case 4:
                        SpeakString ( "So there I was with this fish on the line....");
                        break;  
                        case 5:
                        SpeakString ( "How is your family doing?");
                        break;  
                        case 6:
                        SpeakString ( "I wonder if I can get someone else to take my next shift?");
                        break; 
                        case 7:
                        SpeakString ( "I'm not even supposed to be here today.");
                        break;   
                        case 8:
                        SpeakString ( "...thats what i think they are after also, honesty through paranoia.");
                        break;     
                        case 9:
                        SpeakString ( "I can't beleive this has happened.");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 24: //training one liners NpcTraining1
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "Good? Bad? I'm the one with the sword.");
                        break;
                        case 1:
                        SpeakString ( "Come get some.");
                        break;
                        case 2:
                        SpeakString ( "Do you feel lucky? Well, do ya");
                        break;                    
                        case 3:
                        SpeakString ( "Hate to shatter your ego, but this ain't the first time I've had a sword pointed at me.");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 25: //training one liners NpcTraining2
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "Good? Bad? I'm the one with the sword.");
                        break;
                        case 1:
                        SpeakString ( "Come get some.");
                        break;
                        case 2:
                        SpeakString ( "Do you feel lucky? Well, do ya");
                        break;                    
                        case 3:
                        SpeakString ( "Hate to shatter your ego, but this ain't the first time I've had a sword pointed at me.");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }  
                }
			break;	       
            case 26: //trainer pace one liners NpcTrainerPace
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "C'mon you maggots, train like you mean it");
                        break;
                        case 1:
                        SpeakString ( "My little sister could take you down!");
                        break;
                        case 2:
                        SpeakString ( "My grandmother could whoop you while she was drunk.");
                        break;                    
                        case 3:
                        SpeakString ( "Alright! Back in line.");
                        break;                    
                        case 4:
                        SpeakString ( "Never have I seen such a group of WEAK recruits.");
                        break;  
                        case 5:
                        SpeakString ( "Did you just join the guards for the food?");
                        break;  
                        case 6:
                        SpeakString ( "My little sister's kitten could kill you with one paw tied behind her back.");
                        break; 
                        case 7:
                        SpeakString ( "Remember the pointy end is for your enemy!");
                        break;   
                        case 8:
                        SpeakString ( "If you don't learn soon you will die in the first battle.");
                        break;     
                        case 9:
                        SpeakString ( "Your enemies won't care if it hurts, work through it.");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 27: //WWP one liners NpcWwp
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "What was that?");
                        break;
                        case 1:
                        SpeakString ( "Hmmm... something doesn't look right here.");
                        break;
                        case 2:
                        SpeakString ( "hmmm.. hmmm.. ha humm humm ha hummmm...");
                        break;                    
                        case 3:
                        SpeakString ( "At least I am not on post duty, that is seriously boring.");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 28: //cheer one liners NpcCheer
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "huzzaahhh");
                        break;
                        case 1:
                        SpeakString ( "you go!");
                        break;
                        case 2:
                        SpeakString ( "Ha ha ha ha!");
                        break;                    
                        case 3:
                        SpeakString ( "I love it!");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	
            case 29: //cook one liners NpcMultiCook
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner)
                        {
                        case 0:
                        SpeakString ( "OUCH!");
                        break;
                        case 1:
                        SpeakString ( "you would think I could get something better than turnips once in a while");
                        break;
                        case 2:
                        SpeakString ( "mmmm.. this smells good!");
                        break;                    
                        case 3:
                        SpeakString ( "red meat isn't bad for you... now if it's green...");
                        break;                    
                        case 4:
                        SpeakString ( "OK!!! That's not my hair, who put that in the soup?");
                        break;  
                        case 5:
                        SpeakString ( "Do we have rats or is that a caper?");
                        break;  
                        case 6:
                        SpeakString ( "Surprise! There's tuna in it!");
                        break; 
                        case 7:
                        SpeakString ( "hmmm.. the other OTHER white meat");
                        break;   
                        case 8:
                        SpeakString ( "Hey! Ya you, does this smell like it's turned?");
                        break;     
                        case 9:
                        SpeakString ( "Where did I put that knife?");
                        break;                                                                       
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;
			case 38: //Merchant one liners NpcMerchantMulti
                {switch (nRand)
                {
                case 0:
                    {switch (nOneliner4)
                        {
                        case 0:
                        SpeakString ( "The finest goods in all of the land right here, come and see!");
                        break;
                        case 1:
                        SpeakString ( "Only top quality products");
                        break;
                        case 2:
                        SpeakString ( "mumble..mumble....bunch of tight wads.");
                        break;                    
                        case 3:
                        SpeakString ( "Our prices are so low we lose money on every deal and make it up in volume.");
                        break;                                                              
                        }
                    }
                break;
                default:
                break;
                }
                }
			break;	                                                                                                                    
            }
        }
    break;
    }
}
}