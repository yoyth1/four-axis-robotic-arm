#include "stm32f10x.h"                  // Device header
#include "Motor.h"
#include <math.h>
#include "Emm_V5.h"
#include "Serial.h"
#include "OLED.h"
#include "Delay.h"
#include "Servo.h"
void SetStepMotor(u8 *Arry)   //解析关节角度值并发送给电机驱动
{
	int16_t Angles[6];
	for(u8 i=0;i<6;i++)
	{
		Angles[i]=((int16_t)Arry[2*i])<<8;
		Angles[i]|=(int16_t)Arry[2*i+1]; 
	}
	Emm_V5_Pos_Control(1, (Angles[0]>=0)? 1:0, MoterSpeed, MoterAcc, abs((int)(Angles[0]*0.78125))*4, 1, 0);//设置第一关节角度   4为减速比
	Delay_ms(10);
	Emm_V5_Pos_Control(2, (Angles[1]>=0)? 1:0, MoterSpeed, MoterAcc, abs((int)(Angles[1]*0.78125))*4, 1, 0);//设置第二关节角度
	Delay_ms(10);
	Emm_V5_Pos_Control(3, (Angles[2]>=0)? 1:0, MoterSpeed, MoterAcc, abs((int)(Angles[2]*0.78125))*3, 1, 0);
	Delay_ms(10);
	Emm_V5_Pos_Control(4, (Angles[3]>=0)? 1:0, MoterSpeed, MoterAcc, abs((int)(Angles[3]*0.78125))*1, 1, 0);
	Delay_ms(10);
	Servo1_SetAngle((float)((180.0*Angles[5]/32768.0)+90));   //设置关节五舵机角度
	Servo_SetAngle((float)((180.0*Angles[5]/32768.0)+90));    //设置夹爪舵机角度
		
	//设置舵机和四五关节
}


void USART2_IRQHandler(void)  //接收到数据后对数据进行解析
{
	static uint8_t RxState = 0;
	static uint8_t pRxPacket = 0;
	if (USART_GetITStatus(USART2, USART_IT_RXNE) == SET)
	{
		uint8_t RxData = USART_ReceiveData(USART2);
		
		if (RxState == 0)
		{
			if (RxData == 0xA5)
			{
				RxState = 1;
				pRxPacket = 0;
			}
		}
		else if (RxState == 1)
		{
			Serial_RxPacket[pRxPacket] = RxData;
			pRxPacket ++;
			if (pRxPacket >= 12)
			{
				RxState = 2;
			}
		}
		else if (RxState == 2)
		{
			if (RxData == 0x66)
			{
				RxState = 0;
				Serial_RxFlag = 1;		
				SetStepMotor(Serial_RxPacket);
			}
		}	
		USART_ClearITPendingBit(USART2, USART_IT_RXNE);
			
	}
}



void EXTI1_IRQHandler(void)  //外部中断函数，按下实现急停
{
	if (EXTI_GetITStatus(EXTI_Line1) == SET)
	{
		int i=100;
		while(i!=0)              //延时  消抖
			i--;
 
		
		
		
		
		
      if (GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_1) == 0)
	{
//		OLED_ShowString(4, 1, "Start");
//		TIM_Cmd(TIM3, ENABLE);
//		Emm_V5_En_Control(0,0, 0);   //失能电机驱动
		Serial_SendByte(0xA5);	    
		Serial_SendByte(0x23);       //发送开始示教指令
		Serial_SendByte(0x66);

	}
	
	
	
	else if (GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_0) == 1)
		{
//			TIM_Cmd(TIM3, DISABLE);
//			Emm_V5_En_Control(0,1, 0);
//			OLED_ShowString(4, 1, "End");	
			Serial_SendByte(0xA5);	
			Serial_SendByte(0x24);	//发送停止示教指令
			Serial_SendByte(0x66);
		}	

		
		
		
		
		

		EXTI_ClearITPendingBit(EXTI_Line1);   

	}
}



void TIM3_IRQHandler(void)  //外部中断函数，按下实现实物驱动
{
	if (TIM_GetITStatus(TIM3, TIM_IT_Update) == SET)
	{
				
			for(u8 i=0;i<4;i++)
			{
               __IO uint16_t t0 = 0;  

				Emm_V5_Read_Sys_Params(i+1,S_CPOS); // 读取参数
				
				while(rxFrameFlag==false)        //接收到一帧数据					
				{
					++t0; if(t0 > 3000)	{	break; }
				}
					
				if(rxFrameFlag)
				{
					Serial_TxPacket[4*i] =rxCmd[2];
					Serial_TxPacket[4*i+1] =rxCmd[4]; //地址 + 0x37 + 符号 + 电机位置+ 校验字节  01 表示负数(00 表示正数)，00 01 00 00 表示电机实时位置值
					Serial_TxPacket[4*i+2] =rxCmd[5];
					Serial_TxPacket[4*i+3] =rxCmd[6];

				}
				rxFrameFlag=false;
			}

				Serial_SendPacket();
			    TIM_ClearITPendingBit(TIM3, TIM_IT_Update);
			
	}
}


void EXTI0_IRQHandler(void)  //外部中断 实现按键按下开始拖动示教
{
	if (EXTI_GetITStatus(EXTI_Line0) == SET)
	{
		int i=100;
		while(i!=0)              //延时  消抖
			i--;

		if (GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_0) == 0)
	{
		OLED_ShowString(4, 1, "Physical Drive");
		TIM_Cmd(TIM3, ENABLE);
		Emm_V5_En_Control(0,0, 0);   //失能电机驱动
//		Serial_SendByte(0xA5);	    
//		Serial_SendByte(0x23);       //发送开始示教指令
//		Serial_SendByte(0x66);

	}
	
	
	
	else if (GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_0) == 1)
		{
			TIM_Cmd(TIM3, DISABLE);
			Emm_V5_En_Control(0,1, 0);
			OLED_ShowString(4, 1, "Virtual Drive");	
//			Serial_SendByte(0xA5);	
//			Serial_SendByte(0x24);	//发送停止示教指令
//			Serial_SendByte(0x66);
		}	

		EXTI_ClearITPendingBit(EXTI_Line0);   

	}
	
}



void EXTI15_10_IRQHandler(void)  //急停
{
	OLED_ShowString(4, 1, "End");
	if (EXTI_GetITStatus(EXTI_Line10) == SET)
	{
		int i=100;
		while(i!=0)              //延时消抖
			i--;

	//	//	如果出现数据乱跳的现象，再次判断引脚电平，以避免抖动
		if (GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_1) == 0)
	{
		Emm_V5_Stop_Now(0, 0); // 让电机立即停止运动
		//Emm_V5_En_Control(0,0,0);  //失能电机
	}
	   else  if (GPIO_ReadInputDataBit(GPIOB, GPIO_Pin_1) == 1)
	{
		Emm_V5_Stop_Now(0, 0); // 让电机立即停止运动
		//Emm_V5_En_Control(0,0,0);  //失能电机
	}
		
		
		
		
    }
	EXTI_ClearITPendingBit(EXTI_Line10);   

	
}

