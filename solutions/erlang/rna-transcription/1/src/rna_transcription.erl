-module(rna_transcription).

-export([to_rna/1]).


to_rna("") -> [];
to_rna(Strand) -> to_rna(Strand,"").

to_rna([], Acc) -> Acc;
to_rna([$A|Tail], Acc) -> to_rna(Tail, Acc ++ "U");
to_rna([$C|Tail], Acc) -> to_rna(Tail, Acc ++ "G");
to_rna([$G|Tail], Acc) -> to_rna(Tail, Acc ++ "C");
to_rna([$T|Tail], Acc) -> to_rna(Tail, Acc ++ "A");

to_rna([Head|Tail], Acc) -> erlang:error(badarg,[Head,Tail, Acc]).
