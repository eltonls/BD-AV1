# Recuperação De Falhas

A gestão de falhas em um sistema de banco de dados SQL Server é essencial para garantir a integridade e a disponibilidade dos dados. Quando ocorre uma falha, o banco de dados pode se tornar inconsistente e inutilizável. A recuperação de falhas é um procedimento fundamental que visa restaurar o banco de dados ao seu estado consistente e funcional.
## Tipos de Falhas:

1. **Falha de Transação**:
   - **Causas**: Isso ocorre quando uma transação termina de forma anormal devido a várias razões, como violação de restrições de integridade referencial, definição inadequada da lógica da transação, deadlock ou cancelamento pelo usuário. É importante notar que essa falha não afeta a memória principal nem o armazenamento em disco. A recuperação desse tipo de falha é geralmente rápida, pois a memória principal não é comprometida.

2. **Falhas de Sistema**:
   - **Causas**: Essas falhas ocorrem quando o Sistema de Gerenciamento de Banco de Dados (SGBD) encerra sua execução de forma anormal devido a interrupção de energia, falha no sistema operacional, erros internos no software do SGBD ou falhas de hardware. Nesse caso, a memória principal pode ser afetada, mas o armazenamento em disco geralmente permanece intacto. A recuperação envolve ações como "Global UNDO" e "Partial REDO", sendo o tempo de recuperação de média probabilidade.

3. **Falhas de Mídia**:
   - **Causas**: Falhas de mídia ocorrem quando o banco de dados se torna total ou parcialmente inacessível devido a setores corrompidos no disco ou falhas no cabeçote de leitura/gravação do dispositivo de armazenamento. Nesse caso, a memória principal não é afetada, mas o disco é comprometido. A recuperação de falhas de mídia envolve ações como "Global REDO" e, devido à sua baixa probabilidade de ocorrência, o tempo de recuperação é geralmente maior.

## Técnicas de Recuperação:
As técnicas de recuperação são as ferramentas e estratégias que permitem recuperar o banco de dados após uma falha. Essas falhas podem ser classificadas em duas categorias: falhas catastróficas e falhas não catastróficas.

- **Recuperação de Falhas Catastróficas**: Em casos de falhas graves, a abordagem recomendada é restaurar uma cópia anterior do banco de dados e reaplicar todas as transações registradas no log até o momento da falha. Isso garante uma restauração quase completa do banco de dados, embora a estratégia utilizada possa resultar em perdas de dados maiores ou menores, dependendo das circunstâncias.

- **Recuperação de Falhas Não Catastróficas**: Em situações menos críticas, a recuperação envolve a reversão das alterações que causaram a inconsistência, desfazendo operações de transações não confirmadas ou refazendo operações de transações confirmadas. Esse processo é geralmente mais simples e menos intrusivo do que a recuperação de falhas catastróficas.

## Recuperações (Exemplos)
Aqui estão exemplos de cada tipo de falha em um banco de dados SQL Server, juntamente com as etapas para sua recuperação:
### Exemplo 1: Falha de Transação

**Cenário**:
Suponha que uma transação de transferência de fundos entre duas contas bancárias seja interrompida abruptamente devido a um erro do aplicativo durante a transferência.

**Recuperação**:
1. Identificação da Falha: O sistema detecta que a transação não foi concluída corretamente e que os saldos das contas estão inconsistentes.
2. Desfazer a Transação Incompleta: A transação de transferência incompleta é desfeita, revertendo qualquer alteração feita nas contas bancárias envolvidas.
3. Registrar a Falha: Um registro da falha é mantido para fins de auditoria e rastreamento.
4. Retomar a Transação: A transação é reiniciada a partir do ponto em que foi interrompida, garantindo que os saldos das contas sejam atualizados corretamente.

### Exemplo 2: Falhas de Sistema

**Cenário**:
Imagine que um servidor de banco de dados SQL Server sofra uma falha de hardware devido a um problema na unidade de disco rígido.

**Recuperação**:
1. Substituir o Hardware Defeituoso: A unidade de disco rígido defeituosa é substituída por uma unidade funcional.
2. Restaurar a Última Cópia de Segurança: Uma cópia de segurança recente do banco de dados é restaurada no novo hardware.
3. Aplicar Registros de Log: Os registros de log do banco de dados são aplicados para refazer as transações desde o último backup, garantindo que todos os dados sejam atualizados até o ponto da falha.
4. Verificar Integridade: O banco de dados é verificado quanto à integridade para garantir que não haja corrupção de dados.
5. Reiniciar o Sistema: O servidor do banco de dados é reiniciado, e o sistema volta ao funcionamento normal.

### Exemplo 3: Falhas de Mídia

**Cenário**:
Suponha que um disco rígido que armazena parte de um banco de dados SQL Server apresente setores corrompidos devido a problemas físicos.

**Recuperação**:
1. Isolar o Disco Defeituoso: O disco rígido defeituoso é isolado e removido do sistema.
2. Substituir o Disco: Um novo disco rígido é instalado para substituir o defeituoso.
3. Restaurar a Última Cópia de Segurança: Uma cópia de segurança recente do banco de dados é restaurada no novo disco.
4. Aplicar Registros de Log: Os registros de log do banco de dados são aplicados para refazer as transações desde o último backup até o momento da falha.
5. Verificar Integridade: Uma verificação de integridade é executada no banco de dados para garantir que não haja corrupção de dados.
6. Reiniciar o Sistema: O servidor do banco de dados é reiniciado, e o sistema volta ao funcionamento normal.

Lembre-se de que a eficácia da recuperação depende da manutenção adequada de cópias de segurança regulares e da implementação de estratégias de recuperação apropriadas para cada tipo de falha.
