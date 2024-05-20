import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:studio_partner_app/src/features/home/domain/entity/chat_entity.dart';
import 'package:studio_partner_app/src/features/home/domain/usecase/get_chat.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChat _getChat;
  ChatBloc({
    required GetChat getChat,
  })  : _getChat = getChat,
        super(ChatInitial()) {
    on<ChatEvent>((event, emit) {
      emit(ChatLoadingState());
    });
    on<GetChatEvent>(
      (event, emit) async {
        final res = await _getChat.call(event.agentId);
        res.fold((l) => emit(ChatFailureState(message: l.message)),
            (r) => emit(ChatSuccessState(chats: r)));
      },
    );
  }
}
