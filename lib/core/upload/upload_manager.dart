
// import 'dart:collection';

// import 'package:sympla_app/core/domain/repositories/abstracts/atividade_repository.dart';
// import 'package:sympla_app/core/network/dio_client.dart';
// import 'package:sympla_app/core/storage/converters/status_atividade_converter.dart';

// class UploadManager {
//   final Queue<UploadItem> _fila = Queue();
//   final DioClient _dio;
//   final AtividadeRepository _atividadeRepo;

//   UploadManager({
//     required DioClient dio,
//     required AtividadeRepository atividadeRepo,
//   }) : _dio = dio, _atividadeRepo = atividadeRepo;

//   Future<void> adicionarNaFila(String atividadeId) async {
//     final atividade = await _atividadeRepo.getAtividade(atividadeId);
//     if (atividade == null) return;

//     _fila.add(UploadItem(atividade));
//   }

//   Future<void> processarFila() async {
//     while (_fila.isNotEmpty) {
//       final item = _fila.removeFirst();
//       await enviarAtividade(item.atividade.id);
//     }
//   }

//   Future<void> enviarAtividade(String atividadeId) async {
//     final atividade = await _atividadeRepo.getAtividade(atividadeId);
//     if (atividade == null) return;

//     final response = await _dio.post('/atividades/$atividadeId/upload');
//     if (response.statusCode == 200) {
//       atividade.status = StatusAtividade.sincronizado;
//       await _atividadeRepo.updateAtividade(atividade);
//     } else {
//       atividade.status = StatusAtividade.erroUpload;
//       await _atividadeRepo.updateAtividade(atividade);
//     }
//   }
// }