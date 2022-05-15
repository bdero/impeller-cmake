// `fml/trace_event.h` uses this enum.
// TODO(bdero): Remove this dependency from fml.

typedef enum {
  Dart_Timeline_Event_Begin,         // Phase = 'B'.
  Dart_Timeline_Event_End,           // Phase = 'E'.
  Dart_Timeline_Event_Instant,       // Phase = 'i'.
  Dart_Timeline_Event_Duration,      // Phase = 'X'.
  Dart_Timeline_Event_Async_Begin,   // Phase = 'b'.
  Dart_Timeline_Event_Async_End,     // Phase = 'e'.
  Dart_Timeline_Event_Async_Instant, // Phase = 'n'.
  Dart_Timeline_Event_Counter,       // Phase = 'C'.
  Dart_Timeline_Event_Flow_Begin,    // Phase = 's'.
  Dart_Timeline_Event_Flow_Step,     // Phase = 't'.
  Dart_Timeline_Event_Flow_End,      // Phase = 'f'.
} Dart_Timeline_Event_Type;
