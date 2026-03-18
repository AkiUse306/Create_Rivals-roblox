using RivalBackend.Models;

namespace RivalBackend.Services {
    public class MatchmakingService {
        private readonly List<string> _queue = new();

        public (string MatchId, string Queue) Matchmake(MatchRequest req) {
            if (string.IsNullOrWhiteSpace(req.PlayerId)) {
                throw new ArgumentException("PlayerId is required", nameof(req.PlayerId));
            }
            var matchId = $"match-{Guid.NewGuid():N}";
            _queue.Add(req.PlayerId);
            return (matchId, "battle-royale");
        }
    }
}
