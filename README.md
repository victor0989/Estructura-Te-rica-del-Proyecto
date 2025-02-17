# Estructura Teórica del Proyecto

## Puntos Clave
- Sincronización y gestión de tiempos críticos.
- Integración con subsistemas mecánicos mediante protocolos (SPI, I²C, etc.).

## Diagrama del Proyecto
```
       ┌────────────────────────────────────────────┐
       │  Proyecto de Motor Híbrido Integrado       │
       │  (Control Digital, Diseño Mecánico y       │
       │   Propulsión Cuántica/Avanzada)              │
       └────────────────────────────────────────────┘
                           │
                           ▼
┌─────────────────────────────┐      ┌─────────────────────────────┐
│       1. Control Digital    │      │    2. Diseño Mecánico       │
│  (FPGA y Lógica con Vivado)  │      │   (Modelado 3D, PCB, CFD)     │
│                             │      │                             │
│ - FPGA XCU106 UltraScale    │      │ - Turbina: Rotor & Estator  │
│ - Vivado IP Integrator      │      │ - Carcasa y Estructura      │
│ - ADC/DAC y Sensores        │      │ - SimScale / FreeCAD/Onshape  │
└─────────────────────────────┘      └─────────────────────────────┘
                           │                      │
                           └────────────┬─────────┘
                                        ▼
                           ┌─────────────────────────────┐
                           │  3. Teoría Avanzada y        │
                           │  Propulsión Cuántica         │
                           │  (Campos Magnéticos,         │
                           │   Radiación Cósmica,         │
                           │   Agujeros Negros, etc.)     │
                           │                             │
                           │ - Modelado en MATLAB/COMSOL │
                           │ - Ecuaciones de campo       │
                           │ - Parámetros cuánticos y    │
                           │   relativistas              │
                           └─────────────────────────────┘
                                        │
                                        ▼
                           ┌─────────────────────────────┐
                           │  4. Integración y Sinergia   │
                           │  del Sistema                 │
                           │                             │
                           │ - Comunicación entre        │
                           │   subsistemas (digital y      │
                           │   mecánico)                  │
                           │ - Prototipado y Validación   │
                           │ - Optimización Integral      │
                           └─────────────────────────────┘
```

## 1. Control Digital (FPGA y Lógica)
### Objetivo
Desarrollar la lógica digital que monitorice y controle el motor, gestionando la adquisición de datos (sensores) y la activación de actuadores, utilizando una FPGA (por ejemplo, la XCU106 UltraScale).

### Herramientas y Tecnologías
- **Vivado IP Integrator y Verilog HDL**: Para diseñar bloques de procesamiento y comunicación.
- **Interfaces ADC/DAC**: Para convertir señales analógicas de sensores (por ejemplo, presión, temperatura) a datos digitales y viceversa.

### Puntos Clave
- Sincronización y gestión de tiempos críticos.
- Integración con subsistemas mecánicos mediante protocolos (SPI, I²C, etc.).

## 2. Diseño Mecánico
### Objetivo
Crear el modelo físico del motor, incluyendo la carcasa, la turbina (compuesta por rotor y estator) y la disposición de los componentes necesarios para el flujo de aire y combustible.

### Herramientas y Tecnologías
#### Diseño 3D y Modelado
- **Herramientas**: FreeCAD, Onshape, Fusion 360 (versión gratuita).
- **Simulación**: SimScale para CFD y FEA.
#### Diseño de PCB
- **Herramienta**: KiCad para la interconexión de sensores, actuadores y FPGA.

### Puntos Clave
- Integración de un sistema de enfriamiento o disipación de energía.
- Diseño para minimizar vibraciones y maximizar estabilidad en condiciones extremas.

## 3. Teoría Avanzada y Propulsión Cuántica
### Objetivo
Explorar conceptos innovadores en física extrema, como interacción con campos magnéticos y radiación cósmica, inspirándose en tecnologías emergentes.

### Conceptos Teóricos
- **Campos Magnéticos Suspendidos**: Generación de zonas de suspensión influenciando el flujo de energía/materia.
- **Propulsión Basada en Radiación Cósmica y Energía Estelar**: Mecanismos que utilizan radiación y partículas cósmicas.
- **Agujeros Negros y Curvatura Espacio-Tiempo**: Modelos teóricos de interacción con curvaturas espacio-temporales.

# Monitoreo y Control de una Turbina de Gas o Motor a Reacción con ZCU106/ZCU104

## 1. Adquisición de datos desde sensores
Los sensores de temperatura, presión o vibración se conectan a la FPGA a través de:
- **ADC externo (SPI/I2C)** si los sensores son analógicos.
- **GPIO o MIO** si los sensores ya entregan señales digitales.
- **Alternativa**: Usar los **PL I/O (LVCMOS/HP I/O)** para adquirir señales rápidas directamente.

## 2. Procesamiento en FPGA (Vivado + VHDL/Verilog)
- Diseñar un bloque IP que reciba y procese señales en tiempo real.
- Implementar **filtros FIR/IIR en DSP** para mejorar la calidad de la señal.
- Configurar **controladores térmicos** que ajusten la combustión basándose en las métricas adquiridas.

## 3. Comunicación vía Ethernet (Tri-speed, GEM, RGMII)
- Usar el **GEM (Gigabit Ethernet MAC)** de la FPGA y configurar **RGMII** para transmisión de datos en tiempo real.
- Enviar las métricas a un **PC/Servidor con Python** para análisis posterior.

## 4. Integración con Modelos Teóricos (Cantera + Python)
- Comparar los datos adquiridos con **simulaciones termodinámicas en Cantera**.
- Usar **AI/ML (TensorFlow Lite o PyTorch en ARM Cortex-A53)** para predecir fallos o mejorar el rendimiento de la turbina.

## 📊 Diferencias Clave entre ZCU102, ZCU106 y ZCU104

| Característica       | ZCU102      | ZCU106      | ZCU104      |
|----------------------|------------|------------|------------|
| **Lógica FPGA**      | 600K LUTs  | 504K LUTs  | 350K LUTs  |
| **DSP Slices**       | 2520       | 1728       | 1542       |
| **Ethernet**         | 4x GEM (Tri-speed) | 4x GEM | 4x GEM |
| **ADC interno**      | No         | No         | No         |
| **Interfaces**       | RGMII, PCIe, USB | RGMII, PCIe, USB | RGMII, PCIe, USB |
| **Procesador**       | Quad ARM Cortex-A53 + Dual Cortex-R5 | Quad ARM Cortex-A53 + Dual Cortex-R5 | Quad ARM Cortex-A53 + Dual Cortex-R5 |

## ✅ Conclusión
- La **ZCU106 y ZCU102** son más potentes que la **ZCU104**, pero todas soportan el mismo flujo de trabajo.
- Si buscas **más DSP y LUTs** (para procesamiento de señales más intensivo), **ZCU102/ZCU106** son mejores opciones.
- Si se necesitara algo más **compacto y eficiente**, **ZCU104** sigue siendo viable para este tipo de proyectos.

### Herramientas de Modelado y Simulación
- MATLAB/Simscape Multibody, COMSOL Multiphysics: Simulación de campos electromagnéticos y dinámica cuántica.
- Wolfram Mathematica: Ecuaciones de campo y modelos teóricos.

### Puntos Clave
- Marco teórico con validación experimental.
- Integración de efectos cuánticos como módulos adicionales del motor.

## 4. Integración y Sinergia del Sistema
### Objetivo
Unificar los tres frentes para crear un motor híbrido con control digital preciso, estructura mecánica optimizada y una propulsión revolucionaria.

### Estrategia de Integración
#### Fase de Diseño y Simulación
- Simulación individual de cada subsistema con las herramientas mencionadas.
- Ajuste de parámetros y compatibilidad entre interfaces.

#### Fase de Prototipado y Pruebas
- Banco de pruebas para validar la integración de la FPGA con la PCB y sensores/actuadores.
- Simulación de condiciones extremas en laboratorio.

#### Fase de Optimización y Escalado
- Ajuste del diseño basado en resultados de pruebas.
- Optimización de la lógica digital, mecánica y teórica del motor.

