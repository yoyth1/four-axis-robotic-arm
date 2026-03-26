#ifndef __SERIAL_H
#define __SERIAL_H

#include <stdio.h>

extern uint8_t Serial_TxPacket[];
extern uint8_t Serial_RxPacket[];
extern uint8_t Serial_RxFlag;
void Serial_Init(void);
void Serial_SendByte(uint8_t Byte);
void Serial_SendArray(uint8_t *Array, uint16_t Length);
void Serial_SendString(char *String);
void Serial_SendNumber(uint32_t Number, uint8_t Length);
void Serial_Printf(char *format, ...);

void Serial_SendPacket(void);
uint8_t Serial_GetRxFlag(void);




void floatToBytes(float f, uint8_t* bytes) ;        // // 将float类型的数据按照IEEE754标准转换为字节序列
void Serial_Sendfloat(float f);       //   实现传送float
	
#endif
