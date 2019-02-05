#pragma once

#include "rl.net.native.h"

typedef void (*background_callback_t)(const reinforcement_learning::api_status&);
typedef void (*trace_logger_t)(int log_level, const char* msg);

typedef struct livemodel_context {
    reinforcement_learning::live_model* livemodel;
    background_callback_t background_error_callback;
    trace_logger_t trace_logger_callback;
    reinforcement_learning::trace_logger_factory_t* trace_logger_factory;
} livemodel_context_t;

// Global exports
extern "C" {
    // NOTE: THIS IS NOT POLYMORPHISM SAFE!
    API livemodel_context_t* CreateLiveModel(reinforcement_learning::utility::configuration* config);
    API void DeleteLiveModel(livemodel_context_t* livemodel);

    API int LiveModelInit(livemodel_context_t* livemodel, reinforcement_learning::api_status* status = nullptr);
    API int LiveModelChooseRank(livemodel_context_t* livemodel, const char * event_id, const char * context_json, reinforcement_learning::ranking_response* resp, reinforcement_learning::api_status* status = nullptr);
    API int LiveModelChooseRankWithFlags(livemodel_context_t* livemodel, const char * event_id, const char * context_json, unsigned int flags, reinforcement_learning::ranking_response* resp, reinforcement_learning::api_status* status = nullptr);
    API int LiveModelReportActionTaken(livemodel_context_t* livemodel, const char * event_id, reinforcement_learning::api_status* status = nullptr);
    API int LiveModelReportOutcomeF(livemodel_context_t* livemodel, const char * event_id, float outcome, reinforcement_learning::api_status* status = nullptr);
    API int LiveModelReportOutcomeJson(livemodel_context_t* livemodel, const char * event_id, const char * outcomeJson, reinforcement_learning::api_status* status = nullptr);

    API void LiveModelSetCallback(livemodel_context_t* livemodel, background_callback_t callback = nullptr);
    API void LiveModelSetTrace(livemodel_context_t* livemodel, trace_logger_t trace_logger_callback = nullptr);
}
