-module(rna_transcription).

-export([to_rna/1]).

to_rna("") -> [];
to_rna(Strand) -> to_rna(Strand, []).

to_rna([], Acc) -> lists:reverse(Acc);
to_rna([$A | Tail], Acc) -> to_rna(Tail, [$U|Acc]);
to_rna([$C | Tail], Acc) -> to_rna(Tail, [$G|Acc]);
to_rna([$G | Tail], Acc) -> to_rna(Tail, [$C|Acc]);
to_rna([$T | Tail], Acc) -> to_rna(Tail, [$A|Acc]);
to_rna([Head | Tail], Acc) ->
    erlang:error(badarg, [Head, Tail, Acc]).
