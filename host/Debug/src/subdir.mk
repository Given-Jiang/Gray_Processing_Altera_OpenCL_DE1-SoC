################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../src/main.cpp 

OBJS += \
./src/main.o 

CPP_DEPS += \
./src/main.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	arm-linux-gnueabihf-g++ -I"E:\SOC_SDK\Quartus\hld\board\terasic\de1soc\design\Gray_Processing\host\common\inc" -I"E:\SOC_SDK\SOCEDS\embedded\ds-5\include\opencv" -I"E:\SOC_SDK\SOCEDS\embedded\ds-5\include\opencv\opencv" -I"E:\SOC_SDK\SOCEDS\embedded\ds-5\include\opencv\opencv2" -I"E:\SOC_SDK\Quartus\hld\host\include" -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


