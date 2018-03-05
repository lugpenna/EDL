import Html exposing (text)

-- Considere uma turma de 50 alunos.
-- Cada aluno possui duas notas.
-- O aluno que ficou com média maior ou igual a sete é considerado aprovado.

-- Considere as seguintes definições em Elm para os tipos Aluno e Turma:

type alias Aluno = (String, Float, Float) -- Aluno é um tipo tupla com o nome e as duas notas
type alias Turma = List Aluno             -- Turma é um tipo lista de alunos

-- O nome ou a média de um aluno pode ser obtido através das seguintes funções:

media: Aluno -> Float
media (_,n1,n2) = (n1+n2)/2     -- o nome é ignorado

nome: Aluno -> String
nome (nm,_,_) = nm              -- as notas são ignoradas

-- Por fim, considere as assinaturas para as funções map, filter, e fold a seguir:

--List.map: (a->b) -> (List a) -> (List b)
  -- mapeia uma lista de a's para uma lista de b's com uma função de a para b

--List.filter: (a->Bool) -> (List a) -> (List a)
  -- filtra uma lista de a's para uma nova lista de a's com uma função de a para Bool

--List.foldl : (a->b->b) -> b -> List a -> b
  -- reduz uma lista de a's para um valor do tipo b
        -- usa um valor inicial do tipo b
        -- usa uma função de acumulacao que
            -- recebe um elemento da lista de a
            -- recebe o atual valor acumulado
            -- retorna um novo valor acumulado

-- Usando as definições acima, forneça a implementação para os três trechos marcados com <...>:

turma: Turma
turma = [ ("Joao",7,4), ("Maria",10,8), ("Renato", 2, 3), ("Giovana", 10, 7), ("Luan", 4.7, 8), ("Josue", 8, 7.5), ("William", 9, 10) ]        -- 50 alunos

-- a) LISTA COM AS MÉDIAS DOS ALUNOS DE "turma" ([5.5, 9, ...])
medias: List Float
medias = List.map media turma

-- b) LISTA COM OS NOMES DOS ALUNOS DE "turma" APROVADOS (["Maria", ...])
isAprovado: Aluno -> Bool
isAprovado aluno = (media aluno) >= 7

aprovados: List String
aprovados = List.map nome (List.filter isAprovado turma)

-- c) MÉDIA FINAL DOS ALUNOS DE "turma" (média de todas as médias)
somaMedias: Aluno -> Float -> Float
somaMedias aluno soma = (media aluno) + soma

calcMedia: List Aluno -> Float
calcMedia alunos = (List.foldl somaMedias 0 alunos) / (toFloat (List.length alunos))

total: Float
total = calcMedia turma

-- d) LISTA DE ALUNOS QUE GABARITARAM A P1 ([("Maria",10,8), ...])
gabaritouP1: Aluno -> Bool
gabaritouP1 (_, p1, _) = p1 == 10

turma_dez_p1: Turma
turma_dez_p1 = List.filter gabaritouP1 turma

-- e) LISTA COM OS NOMES E MEDIAS DOS ALUNOS APROVADOS ([("Maria",9), ...])
listaMedia: Aluno -> (String, Float)
listaMedia (nome, p1, p2) = (nome, media (nome, p1, p2))

mediaAprovados: Turma -> List (String, Float)
mediaAprovados turma = List.map listaMedia (List.filter isAprovado turma)

aprovados2: List (String,Float)
aprovados2 = mediaAprovados turma

-- f) LISTA COM TODAS AS NOTAS DE TODAS AS PROVAS ([7,4,10,8,...])
concatenaNotas: Aluno -> List Float -> List Float
concatenaNotas (_, p1, p2) notas = p1 :: p2 :: notas

notas: List Float
notas = List.foldr concatenaNotas [] turma

-- É permitido usar funções auxiliares, mas não é necessário.
-- (As soluções são pequenas.)

main = text (toString turma)
