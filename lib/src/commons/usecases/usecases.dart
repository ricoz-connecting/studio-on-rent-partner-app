abstract interface class Usecases<Params, ReturnType> {
  ReturnType call(Params params);
}
